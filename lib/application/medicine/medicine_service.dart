import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class MedicineService {
  final UserRepositoryInterface _userRepositoryInterface;
  final MedicineRepositoryInterface _medicineRepository;

  const MedicineService(
      this._userRepositoryInterface, this._medicineRepository);

  Stream<QuerySnapshot<Medicine>> getMedicinesByUserID() {
    return _medicineRepository
        .fetchMedicinesByUserID(_userRepositoryInterface.getCurrentUser());
  }

  void addNewMedicine(Medicine newMedicine) {
    _medicineRepository.save(
        _userRepositoryInterface.getCurrentUser(), newMedicine);
  }

  Future<Medicine> getUser(String medicineID) async => await _medicineRepository
      .fetchMedicineByID(_userRepositoryInterface.getCurrentUser(), medicineID);
}
