import 'dart:collection';

import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';

class PhotoRepositoryMock implements PhotoRepositoryInterface {
  List<String> _imageList = [
    'images/2532x1170.png',
    'images/IMG_3847.jpeg',
    'images/2532x1170.png',
    'images/2532x1170.png',
    'images/2532x1170.png',
    'images/2532x1170.png',
  ];

  @override
  Future<List<Photo>> findAll() {
    return Future.value(
        UnmodifiableListView(_imageList.map((path) => Photo(path: path))));
  }
}
