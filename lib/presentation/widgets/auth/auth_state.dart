import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool _isLogin = false;
  bool _isLinked = false;

  bool get isLinked => _isLinked;

  void linked(bool isLink) {
    _isLinked = isLink;
    notifyListeners();
  }

  bool get isLogin => _isLogin;
  void loggedin(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }
}
