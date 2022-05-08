import 'dart:async';

import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class UserService {
  final UserRepositoryInterface _userRepositoryInterface;

  const UserService(
    this._userRepositoryInterface,
  );

  String getUserID() {
    return _userRepositoryInterface.getCurrentUser();
  }

  bool isLinked() {
    return _userRepositoryInterface.isLinked();
  }

  bool isLogin() {
    return _userRepositoryInterface.isLogin();
  }

  // StreamSubscription<User?> signInAnonymously() {
  //   return _userRepositoryInterface.signin();
  // }

  Future<void> signInAnonymously() {
    return _userRepositoryInterface.signin();
  }

  Future<void> linkWithEmailAndPassword(String email, String password) async {
    await _userRepositoryInterface.linkWithEmailAndPassword(email, password);
  }

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    _userRepositoryInterface.signinWithEmailAndPassword(email, password);
  }

  Future<bool> signout() async {
    return _userRepositoryInterface.signout();
  }

  Future<void> withdrawal() async {
    _userRepositoryInterface.withdrawal();
  }
}
