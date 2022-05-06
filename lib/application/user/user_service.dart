import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class UserService {
  final UserRepositoryInterface _userRepositoryInterface;

  const UserService(
    this._userRepositoryInterface,
  );

  String getUserID() {
    return _userRepositoryInterface.getCurrentUser();
  }

  StreamSubscription<User?> signInAnonymously() {
    return _userRepositoryInterface.signin();
  }
}
