import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/repository/firebase/initialization.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  String getCurrentUser() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  StreamSubscription<User?> signin() {
    return FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        await FirebaseAuth.instance.signInAnonymously();
      } else {
        await InitializationService().createSample(user.uid);
      }
    });
  }
}
