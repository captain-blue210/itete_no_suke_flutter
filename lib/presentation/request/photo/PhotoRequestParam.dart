import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

class PhotoRequestParam with ChangeNotifier {
  List<Photo> _selected = <Photo>[];

  List<Photo> get selectedPhotos => List<Photo>.unmodifiable(_selected);

  void addSelectedPhoto(Photo selected) {
    if (!contains(selected)) {
      _selected.add(selected);
      notifyListeners();
    }
  }

  void removeSelectedPhoto(Photo selected) {
    _selected.removeWhere((photo) => photo.photoURL == selected.photoURL);
    notifyListeners();
  }

  void removeAll() {
    _selected.clear();
    notifyListeners();
  }

  bool contains(Photo target) {
    return _selected.any((photo) => photo.photoURL == target.photoURL);
  }
}
