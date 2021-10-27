import 'dart:collection';

import 'package:itetenosukte_flutter/model/medicine/medicine.dart';
import 'package:itetenosukte_flutter/model/medicine/medicine_repository_interface.dart';

class MedicineRepositoryMock implements MedicineRepositoryInterface {
  static final List<String> _medicineList = [
    "お薬1",
    "お薬2",
    "お薬3",
    "お薬4",
    "お薬5",
  ];

  @override
  Future<List<Medicine>> findAll() {
    return Future.value(UnmodifiableListView(
        _medicineList.map((name) => Medicine(name: name))));
  }
}
