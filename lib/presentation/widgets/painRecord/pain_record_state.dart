import 'package:flutter/material.dart';

class PainRecordState extends ChangeNotifier {
  bool _isLoading = false;

  void toggleLoading() {
    print('before isLoading: ${_isLoading}');
    _isLoading = !_isLoading;
    print('before isLoading: ${_isLoading}');
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
