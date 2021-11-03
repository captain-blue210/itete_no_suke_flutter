import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class MedicineService {
  final UserRepositoryInterface _userRepositoryInterface;
  final MedicineRepositoryInterface _medicineRepository;

  const MedicineService(
      this._userRepositoryInterface, this._medicineRepository);

  Stream<QuerySnapshot<Medicine>> getMedicinesByUserID(String userID) {
    return _medicineRepository.fetchMedicinesByUserID(userID);
  }

  Future<void> addNewMedicine(Medicine newMedicine) {
    return _medicineRepository.save(
        _userRepositoryInterface.getCurrentUser(), newMedicine);
  }
}
