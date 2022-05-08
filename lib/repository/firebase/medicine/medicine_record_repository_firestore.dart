import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';

class MedicineRecordRepositoryFirestore implements MedicineRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  MedicineRecordRepositoryFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
    }
  }

  @override
  Future<List<Medicine>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Stream<List<Medicine>> fetchMedicinesByUserID(String userID) async* {
    var medicineStream = getMedicineRef(userID)
        .orderBy('createdAt', descending: true)
        .snapshots();
    var medicines = <Medicine>[];
    await for (var snapshot in medicineStream) {
      for (var medicine in snapshot.docs) {
        medicines.add(medicine.data());
      }
      yield medicines;
    }
  }

  @override
  Future<List<Medicine>?> fetchMedicinesByPainRecordsID(
      String userID, String painRecordsID) {
    // TODO: implement fetchMedicinesByUserID
    throw UnimplementedError();
  }

  @override
  Future<void> save(String userID, Medicine newMedicine) async {
    (await getMedicineRef(userID)).add(newMedicine);
  }

  CollectionReference<Medicine> getMedicineRef(String userID) {
    final medicineRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .withConverter<Medicine>(
            fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
            toFirestore: (medicine, _) => medicine.toJson());
    return medicineRef;
  }

  DocumentReference<Medicine> getMedicineRefByID(
      String userID, String medicineID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .doc(medicineID)
        .withConverter<Medicine>(
            fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
            toFirestore: (medicine, _) => medicine.toJson());
  }

  @override
  Future<Medicine> fetchMedicineByID(String userID, String medicineID) async {
    return getMedicineRefByID(userID, medicineID)
        .get()
        .then((medicine) => medicine.data()!.copyWith(ref: medicine.reference));
  }

  @override
  void update(String userID, Medicine updated) {
    getMedicineRefByID(userID, updated.id!).update(updated.toJson());
  }

  DocumentReference<Medicine> _getMedicinesRef(
      String userID, String medicineID) {
    final medicinesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .doc(medicineID)
        .withConverter<Medicine>(
          fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
          toFirestore: (medicine, _) => medicine.toJson(),
        );
    return medicinesRef;
  }

  @override
  void delete(String userID, String medicineID) async {
    getMedicineRefByID(userID, medicineID).delete();

    // painrecord配下のmedicineもすべて削除する
    var painRecords = (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('painRecords')
            .withConverter<PainRecord>(
                fromFirestore: (snapshot, _) {
                  if (!snapshot.metadata.hasPendingWrites) {
                    return PainRecord.fromJson(snapshot.data()!)
                        .copyWith(id: snapshot.id);
                  } else {
                    var updated = snapshot.data()!.map((key, value) => MapEntry(
                        key, key == "updatedAt" ? Timestamp.now() : value));
                    return PainRecord.fromJson(updated)
                        .copyWith(id: snapshot.id);
                  }
                },
                toFirestore: (painRecord, _) => painRecord.toJson())
            .get())
        .docs;

    for (var painRecord in painRecords) {
      // medicineを取得
      final painRecordMedicines = (await FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .collection("painRecords")
              .doc(painRecord.id)
              .collection('medicines')
              .withConverter<Medicine>(
                fromFirestore: (snapshot, _) =>
                    Medicine.fromJson(snapshot.data()!).copyWith(
                        id: snapshot.data()!['medicineRef'].id,
                        painRecordMedicineId: snapshot.id,
                        ref: _getMedicinesRef(
                            userID, snapshot.data()!['medicineRef'].id)),
                toFirestore: (medicine, _) => medicine.toJson(),
              )
              .get())
          .docs;

      for (var medicine in painRecordMedicines) {
        if (medicine.data().medicineRef.toString().contains(medicineID)) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .collection("painRecords")
              .doc(painRecord.id)
              .collection('medicines')
              .doc(medicine.id)
              .delete();
        }
      }
    }
  }
}
