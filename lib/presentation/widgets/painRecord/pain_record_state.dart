import 'package:flutter/material.dart';

class PainRecordState extends ChangeNotifier {
  bool _isLoading = false;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
