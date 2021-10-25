import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/pages/bodyParts/body_parts_input.dart';
import 'package:itetenosukte_flutter/view/pages/medicine/medicine_input.dart';
import 'package:itetenosukte_flutter/view/pages/painRecord/pain_record_input.dart';
import 'package:itetenosukte_flutter/view/widgets/home/add_button_index.dart';

class AddButton {
  AddButtonIndex _index = AddButtonIndex.painrecord;

  StatefulWidget getAddButton() {
    if (_index == AddButtonIndex.bodyParts) {
      return BodyPartsInput();
    }
    if (_index == AddButtonIndex.medicine) {
      return MedicineInput();
    }
    return PainRecordInput();
  }

  int getCurrentIndex() {
    return _index.index;
  }

  set index(AddButtonIndex newIndex) {
    _index = newIndex;
  }
}
