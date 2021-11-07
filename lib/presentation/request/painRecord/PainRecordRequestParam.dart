import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecordRequestParam with ChangeNotifier {
  PainLevel _painLevel = PainLevel.noPain;

  PainRecordRequestParam();

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }

  PainLevel get painLevel => _painLevel;
}
