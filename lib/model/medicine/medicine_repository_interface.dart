import 'package:itetenosukte_flutter/model/medicine/medicine.dart';

abstract class MedicineRepositoryInterface {
  Future<List<Medicine>> findAll();
}
