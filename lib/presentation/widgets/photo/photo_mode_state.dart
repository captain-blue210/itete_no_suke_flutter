import 'package:flutter/material.dart';

class PhotoModeState extends ChangeNotifier {
  bool _isPhotoSelectMode = false;

  bool get isPhotoSelectMode => _isPhotoSelectMode;

  void togglePhotoSelectMode() {
    _isPhotoSelectMode = !_isPhotoSelectMode;
    notifyListeners();
  }
}
