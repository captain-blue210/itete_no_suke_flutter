import 'dart:async';

import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class UserRepositoryMock implements UserRepositoryInterface {
  @override
  String getCurrentUser() {
    return '9xlYzbQquvzI7knBdCaA';
  }

  // @override
  // StreamSubscription<User?> signin() {
  //   // TODO: implement signin
  //   throw UnimplementedError();
  // }

  @override
  bool isLinked() {
    // TODO: implement isLinked
    throw UnimplementedError();
  }

  @override
  Future<bool> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future<void> withdrawal() {
    // TODO: implement withdrawal
    throw UnimplementedError();
  }

  @override
  Future<void> signinWithEmailAndPassword(String email, String password) {
    // TODO: implement signinWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> linkWithEmailAndPassword(String email, String password) {
    // TODO: implement linkWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }
}
