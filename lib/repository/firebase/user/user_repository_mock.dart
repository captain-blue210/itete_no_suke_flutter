import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class UserRepositoryMock implements UserRepositoryInterface {
  @override
  String getCurrentUser() {
    return '9xlYzbQquvzI7knBdCaA';
  }

  @override
  StreamSubscription<User?> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  bool isLinked() {
    // TODO: implement isLinked
    throw UnimplementedError();
  }
}
