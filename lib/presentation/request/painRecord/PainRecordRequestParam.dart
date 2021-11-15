import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecordRequestParam with ChangeNotifier {
  PainLevel _painLevel = PainLevel.noPain;
  List<Medicine>? _medicines = <Medicine>[];
  List<BodyPart>? _bodyParts = <BodyPart>[];

  PainRecordRequestParam();

  List<Medicine>? getMedicines() => _medicines;
  List<BodyPart>? getBodyParts() => _bodyParts;

  set medicines(Medicine medicine) {
    if (!_medicines!.contains(medicine)) {
      _medicines!.add(medicine);
    }
  }

  set bodyParts(BodyPart bodypart) {
    if (!_bodyParts!.contains(bodypart)) {
      _bodyParts!.add(bodypart);
    }
  }

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }

  PainLevel get painLevel => _painLevel;
}
