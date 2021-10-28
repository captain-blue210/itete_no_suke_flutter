import 'dart:collection';

import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';

class BodyPartsRepositoryMock implements BodyPartsRepositoryInterface {
  static final List<String> _bodyPartsList = [
    "部位1",
    "部位2",
    "部位3",
    "部位4",
    "部位5",
  ];

  @override
  Future<List<BodyPart>> findAll() {
    return Future.value(UnmodifiableListView(
        _bodyPartsList.map((name) => BodyPart(name: name))));
  }
}
