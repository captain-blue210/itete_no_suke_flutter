import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecordRequestParam with ChangeNotifier {
  PainLevel _painLevel = PainLevel.noPain;
  List<Medicine>? _medicines = <Medicine>[];

  PainRecordRequestParam();

  List<Medicine>? getMedicines() => _medicines;

  set medicines(Medicine medicine) {
    if (!_medicines!.contains(medicine)) {
      _medicines!.add(medicine);
    }
  }

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }

  PainLevel get painLevel => _painLevel;
}
