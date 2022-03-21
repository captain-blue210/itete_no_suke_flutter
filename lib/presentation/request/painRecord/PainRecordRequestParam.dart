import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecordRequestParam with ChangeNotifier {
  String? _id;
  PainLevel _painLevel = PainLevel.noPain;
  List<Medicine>? _medicines = <Medicine>[];
  List<BodyPart>? _bodyParts = <BodyPart>[];
  List<XFile>? _photos = <XFile>[];
  String? _memo;

  PainRecordRequestParam();

  String? get id => _id;
  PainLevel get painLevel => _painLevel;
  List<Medicine>? getMedicines() => _medicines;
  List<BodyPart>? getBodyParts() => _bodyParts;
  List<XFile>? getPhotos() => _photos;
  String? get memo => _memo;

  set id(String? id) {
    _id = id;
  }

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

  set photos(XFile image) {
    _photos!.add(image);
    notifyListeners();
  }

  set memo(String? memo) {
    _memo = memo;
  }

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }
}
