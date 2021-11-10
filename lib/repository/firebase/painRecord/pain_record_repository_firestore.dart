import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';

class PainRecordRepositoryFirestore implements PainRecordRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  PainRecordRepositoryFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
    }
  }

  @override
  Future<List<PainRecord>?> fetchPainRecordsByUserID(String userID) async {
    var painRecords = await _getPainRecordsRefByUserID(userID)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();

    var bodyParts = await _getBodyPartsRef(userID, painRecords)
        .get()
        .then((snapshot) => snapshot.docs.map((e) => e.data()).toList());

    return painRecords.docs
        .map((e) => e.data().setBodyParts(bodyParts))
        .toList();
  }

  @override
  Future<List<PainRecord>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<void> save(String userID, PainRecord painRecord) async {
    String painRecordsID = await (_getPainRecordsRefByUserID(userID))
        .add(painRecord)
        .then((value) => value.id);

    for (var medicine in painRecord.medicines!) {
      _getMedicinesRefByUserIDAndPainRecordsID(userID, medicine.medicinesID!)
          .get()
          .then((snapshot) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        batch.update(snapshot.reference, {'painRecordsID': painRecordsID});
        batch.commit();
      });
    }
  }

  CollectionReference<PainRecord> _getPainRecordsRefByUserID(String userID) {
    final painRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) =>
                PainRecord.fromJson(snapshot.data()!),
            toFirestore: (painRecord, _) => painRecord.toJson());
    return painRecordsRef;
  }

  Query<BodyPart> _getBodyPartsRef(
      String userID, QuerySnapshot<PainRecord> snapshot) {
    var bodyPartsRef;
    try {
      bodyPartsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('bodyParts')
          .where('painRecordsID',
              whereIn: snapshot.docs.map((doc) => doc.id).toList())
          .withConverter<BodyPart>(
              fromFirestore: (snapshot, _) =>
                  BodyPart.fromJson(snapshot.data()!),
              toFirestore: (bodyPart, _) => bodyPart.toJson());
    } catch (e) {
      print(e.toString());
    }
    return bodyPartsRef;
  }

  Query<Medicine> _getMedicinesRef(String userID) {
    final medicinesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .withConverter<Medicine>(
          fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
          toFirestore: (medicine, _) => medicine.toJson(),
        );
    return medicinesRef;
  }

  DocumentReference<Medicine> _getMedicinesRefByUserIDAndPainRecordsID(
      String userID, String medicinesID) {
    final medicinesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .doc(medicinesID)
        .withConverter<Medicine>(
          fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
          toFirestore: (medicine, _) => medicine.toJson(),
        );
    return medicinesRef;
  }

  @override
  Future<List<Medicine>?> getMedicineByUserID(String userID) async {
    return (await _getMedicinesRef(userID).get())
        .docs
        .map((e) => Medicine(medicineID: e.id, name: e.data().name))
        .toList();
  }
}
