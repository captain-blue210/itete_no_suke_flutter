import 'dart:async';

abstract class UserRepositoryInterface {
  String getCurrentUser();
  // StreamSubscription<User?> signin();
  Future<void> signin();
  Future<void> linkWithEmailAndPassword(String email, String password);
  Future<void> signinWithEmailAndPassword(String email, String password);
  bool isLinked();
  bool isLogin();
  Future<bool> signout();
  Future<void> withdrawal();
}
