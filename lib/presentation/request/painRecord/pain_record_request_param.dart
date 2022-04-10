import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

class PainRecordRequestParam with ChangeNotifier {
  String? _id;
  PainLevel _painLevel = PainLevel.noPain;
  List<Medicine>? _medicines = <Medicine>[];
  List<BodyPart>? _bodyParts = <BodyPart>[];
  List<Photo>? _photos = <Photo>[];
  String? _memo;

  PainRecordRequestParam();

  String? get id => _id;
  PainLevel get painLevel => _painLevel;
  List<Medicine>? getMedicines() => _medicines;
  List<BodyPart>? getBodyParts() => _bodyParts;
  List<Photo>? getPhotos() => _photos;
  String? get memo => _memo;

  set id(String? id) {
    _id = id;
  }

  set medicines(Medicine medicine) {
    _medicines!.removeWhere((registered) =>
        registered.painRecordMedicineId == medicine.painRecordMedicineId);
    _medicines!.add(medicine);
  }

  set bodyParts(BodyPart bodypart) {
    _bodyParts!.removeWhere((registered) =>
        registered.painRecordBodyPartId == bodypart.painRecordBodyPartId);
    _bodyParts!.add(bodypart);
  }

  set photos(Photo photo) {
    initPhotos(photo);
    notifyListeners();
  }

  set memo(String? memo) {
    _memo = memo;
  }

  set painLevel(PainLevel painLevel) {
    _painLevel = painLevel;
    notifyListeners();
  }

  void initPhotos(Photo photo) {
    _photos!.removeWhere((registered) =>
        registered.painRecordPhotoId == photo.painRecordPhotoId);
    _photos!.add(photo);
  }

  void deleteDeletedPhotos(List<Photo> deleted) {
    for (var photo in deleted) {
      _photos!.removeWhere((e) => e.id == photo.id!);
    }
  }
}