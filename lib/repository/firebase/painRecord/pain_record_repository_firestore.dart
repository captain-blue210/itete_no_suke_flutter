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
  Future<void> save(
    String userID,
    PainRecord painRecord,
    List<Medicine>? medicines,
    List<BodyPart>? bodyParts,
  ) async {
    String painRecordsID = await (_getPainRecordsRefByUserID(userID))
        .add(painRecord)
        .then((ref) => ref.id);

    for (var e in medicines!) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('painRecords')
          .doc(painRecordsID)
          .collection('medicines')
          .add({'medicineRef': e.medicineRef});
    }

    for (var e in bodyParts!) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('painRecords')
          .doc(painRecordsID)
          .collection('bodyParts')
          .add({'bodyPartRef': e.bodyPartRef});
    }
  }

  CollectionReference<PainRecord> _getPainRecordsRefByUserID(String userID) {
    final painRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) {
              PainRecord painRecord = PainRecord.fromJson(snapshot.data()!);
              painRecord.painRecordID = snapshot.id;
              return painRecord;
            },
            toFirestore: (painRecord, _) => painRecord.toJson());
    return painRecordsRef;
  }

  DocumentReference<PainRecord> _getPainRecordsRefByID(
      String userID, String painRecordID) {
    final painRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecordID)
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) {
              PainRecord painRecord = PainRecord.fromJson(snapshot.data()!);
              painRecord.painRecordID = snapshot.id;
              return painRecord;
            },
            toFirestore: (painRecord, _) => painRecord.toJson());
    return painRecordsRef;
  }

  Query<BodyPart> _getBodyPartsRef(
      String userID, QuerySnapshot<PainRecord> snapshot) {
    var bodyPartsRef = FirebaseFirestore.instance
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

  Query<BodyPart> _getBodyPartsRefByPainRecordID(
      String userID, String painRecordID) {
    var bodyPartsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .where('painRecordsID', isEqualTo: painRecordID)
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

  Query<Medicine> _getMedicinesRefByPainRecordID(
      String userID, String painRecordID) {
    final medicinesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .where('painRecordsID', isEqualTo: painRecordID)
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
        .map((e) => Medicine(name: e.data().name).setMedicineID(e.id))
        .toList();
  }

  @override
  Future<List<BodyPart>?> getBodyPartsByUserID(String userID) async {
    return (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('bodyParts')
            .withConverter<BodyPart>(
              fromFirestore: (snapshot, _) =>
                  BodyPart.fromJson(snapshot.data()!),
              toFirestore: (bodyPart, _) => bodyPart.toJson(),
            )
            .get())
        .docs
        .map((e) => BodyPart(name: e.data().name).setBodyPartRef(e.reference))
        .toList();
  }

  @override
  Future<PainRecord> fetchPainRecordByID(
      String userID, String painRecordID) async {
    var painRecord = await _getPainRecordsRefByID(userID, painRecordID).get();

    var medicines = await _getMedicinesRefByPainRecordID(userID, painRecordID)
        .get()
        .then((snapshot) =>
            snapshot.docs.map((e) => e.data().setMedicineID(e.id)).toList());

    var bodyParts = await _getBodyPartsRefByPainRecordID(userID, painRecordID)
        .get()
        .then((snapshot) => snapshot.docs.map((e) => e.data()).toList());

    return painRecord.data()!.setMedicines(medicines).setBodyParts(bodyParts);
  }
}
