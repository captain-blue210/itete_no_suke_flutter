import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';

class Medicines {
  final MedicineRepositoryInterface medicineRepository;

  const Medicines({required this.medicineRepository});

  Future<List<Medicine>> getMedicines() async {
    return await medicineRepository.findAll();
  }

  Future<int> getCounts() async {
    return await medicineRepository
        .findAll()
        .then((medicineList) => medicineList.length);
  }
}
