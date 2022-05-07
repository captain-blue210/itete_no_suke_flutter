import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepositoryInterface {
  String getCurrentUser();
  StreamSubscription<User?> signin();
  bool isLinked();
}
