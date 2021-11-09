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
    final QuerySnapshot<PainRecord> snapshot =
        await _getPainRecordsRefByUserID(userID)
            .orderBy('createdAt', descending: true)
            .get();

    final QuerySnapshot<BodyPart> bodyPartsSnapshot =
        await _getBodyPartsRef(userID, snapshot)
            .orderBy('createdAt', descending: true)
            .get();

    return snapshot.docs.map((painRecord) {
      painRecord.data().bodyParts = bodyPartsSnapshot.docs
          .where((element) => element.get('painRecordsID') == painRecord.id)
          .map((snapshot) => BodyPart(name: snapshot.get('name')))
          .toList();
      return painRecord.data();
    }).toList();
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

    print("IN save : ${painRecord.medicines!.length}");
    List<String?> medicinesIDs =
        painRecord.medicines!.map((e) => e.medicineID).toList();

    WriteBatch batch = FirebaseFirestore.instance.batch();
    _getMedicinesRefByUserIDAndPainRecordsID(userID, medicinesIDs)
        .get()
        .then((snapshot) {
      snapshot.docs.map((doc) =>
          batch.update(doc.reference, {'painRecordsID': painRecordsID}));
    });
    batch.commit();
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
    final bodyPartsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .where('painRecordsID',
            whereIn: snapshot.docs.map((doc) => doc.id).toList())
        .withConverter<BodyPart>(
            fromFirestore: (snapshot, _) => BodyPart.fromJson(snapshot.data()!),
            toFirestore: (bodyPart, _) => bodyPart.toJson());
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

  Query<Medicine> _getMedicinesRefByUserIDAndPainRecordsID(
      String userID, List<String?> medicinesIDs) {
    final medicinesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .where('painRecordsID', whereIn: medicinesIDs)
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
