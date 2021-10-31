import 'package:itete_no_suke/model/medicine/medicine.dart';

abstract class MedicineRepositoryInterface {
  Future<List<Medicine>> findAll();
  Future<List<Medicine>?> fetchMedicinesByUserID(String userID);
  Future<List<Medicine>?> fetchMedicinesByPainRecordsID(
      String userID, String painRecordsID);
}
