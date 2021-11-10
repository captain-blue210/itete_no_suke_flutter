import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecordRequestParam with ChangeNotifier {
  PainLevel _painLevel = PainLevel.noPain;
  List<Medicine>? _medicines;

  PainRecordRequestParam();

  List<Medicine>? getMedicines() => _medicines;

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }

  set medicines(Medicine medicine) {
    _medicines ??= <Medicine>[];
    _medicines!.add(medicine);
  }

  PainLevel get painLevel => _painLevel;
}
