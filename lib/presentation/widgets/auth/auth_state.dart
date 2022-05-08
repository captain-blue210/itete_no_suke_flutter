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

  void link() {
    _isLinked = true;
  }

  void unlink() {
    _isLinked = false;
  }

  void login() {
    _isLogin = true;
  }

  void logout() {
    _isLogin = false;
  }
}
