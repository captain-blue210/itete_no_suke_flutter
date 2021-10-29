import 'package:itete_no_suke/model/medicine/medicine.dart';

abstract class MedicineRepositoryInterface {
  Future<List<Medicine>> findAll();
}
