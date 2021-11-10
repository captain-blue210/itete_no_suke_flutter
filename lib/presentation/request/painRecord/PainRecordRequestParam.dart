import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecordRequestParam with ChangeNotifier {
  PainLevel _painLevel = PainLevel.noPain;
  List<Medicine>? _medicines;
  LinkedHashSet<Medicine> _medicineSet = LinkedHashSet();

  PainRecordRequestParam();

  List<Medicine>? getMedicines() => _medicines;

  set medicines(Medicine medicine) {
    _medicines ??= <Medicine>[];
    _medicines!.add(medicine);
  }

  Set<Medicine> getMedicineSet() => _medicineSet;
  set medicineSet(Medicine medicine) {
    _medicineSet.add(medicine);
  }

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }

  PainLevel get painLevel => _painLevel;
}
