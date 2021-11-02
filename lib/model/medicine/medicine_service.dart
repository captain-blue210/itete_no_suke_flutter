import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';

class MedicineService {
  final MedicineRepositoryInterface _medicineRepository;

  const MedicineService(this._medicineRepository);

  Future<List<Medicine>?> getMedicinesByUserID(String userID) async {
    return await _medicineRepository.fetchMedicinesByUserID(userID);
  }

  Future<void> addNewMedicine(String userID, Medicine newMedicine) {
    return _medicineRepository.save(userID, newMedicine);
  }
}
