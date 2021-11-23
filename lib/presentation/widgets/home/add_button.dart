import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/pages/bodyParts/body_parts_input.dart';
import 'package:itete_no_suke/presentation/pages/medicine/medicine_input.dart';
import 'package:itete_no_suke/presentation/pages/painRecord/pain_record_input.dart';
import 'package:itete_no_suke/presentation/pages/photo/photo_input.dart';
import 'package:itete_no_suke/presentation/widgets/home/add_button_index.dart';

class AddButton {
  AddButtonIndex _index = AddButtonIndex.painrecord;

  StatefulWidget getAddButton() {
    switch (_index) {
      case AddButtonIndex.photo:
        return PhotoInput();
      case AddButtonIndex.bodyParts:
        return BodyPartsInput();
      case AddButtonIndex.medicine:
        return MedicineInput();
      case AddButtonIndex.painrecord:
        return PainRecordInput();
    }
  }

  int getCurrentIndex() {
    return _index.index;
  }

  set index(AddButtonIndex newIndex) {
    _index = newIndex;
  }
}
