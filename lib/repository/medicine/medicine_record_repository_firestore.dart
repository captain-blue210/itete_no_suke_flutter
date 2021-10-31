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
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .get();

    return snapshot.docs.map((doc) => Medicine(doc)).toList();
  }

  @override
  Future<List<Medicine>?> fetchMedicinesByPainRecordsID(
      String userID, String painRecordsID) {
    // TODO: implement fetchMedicinesByUserID
    throw UnimplementedError();
  }
}
