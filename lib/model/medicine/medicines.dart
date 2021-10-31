import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';

class Medicines {
  final MedicineRepositoryInterface medicineRepository;

  const Medicines({required this.medicineRepository});

  Future<List<Medicine>?> getMedicinesByUserID(String userID) async {
    return await medicineRepository.fetchMedicinesByUserID(userID);
  }

  Future<int> getCounts() async {
    return await medicineRepository
        .findAll()
        .then((medicineList) => medicineList.length);
  }
}
