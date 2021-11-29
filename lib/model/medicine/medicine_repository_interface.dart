import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';

abstract class MedicineRepositoryInterface {
  Future<List<Medicine>> findAll();
  Stream<QuerySnapshot<Medicine>> fetchMedicinesByUserID(String userID);
  Future<Medicine> fetchMedicineByID(String userID, String medicineID);
  Future<List<Medicine>?> fetchMedicinesByPainRecordsID(
      String userID, String painRecordsID);
  Future<void> save(String userID, Medicine newMedicine);
  void update(String userID, Medicine updated);
  void delete(String userID, String medicineID);
}
