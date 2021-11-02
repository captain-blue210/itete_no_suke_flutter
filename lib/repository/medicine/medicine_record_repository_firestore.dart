import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';

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
  Future<List<Medicine>?> fetchMedicinesByUserID(String userID) async {
    return (await _getMedicineRef(userID))
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<List<Medicine>?> fetchMedicinesByPainRecordsID(
      String userID, String painRecordsID) {
    // TODO: implement fetchMedicinesByUserID
    throw UnimplementedError();
  }

  @override
  Future<void> save(String userID, Medicine newMedicine) async {
    (await _getMedicineRef(userID)).add(newMedicine);
  }

  Future<CollectionReference<Medicine>> _getMedicineRef(String userID) async {
    final medicineRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .withConverter<Medicine>(
            fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
            toFirestore: (medicine, _) => medicine.toJson());
    return medicineRef;
  }
}
