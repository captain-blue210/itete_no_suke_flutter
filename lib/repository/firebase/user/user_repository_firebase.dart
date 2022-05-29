import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/repository/firebase/initialization.dart';

class UserRepository implements UserRepositoryInterface {
  final EmailAuthProviderID = 'password';

  @override
  String getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '';
    }
    return user.uid;
  }

  // @override
  // StreamSubscription<User?> signin() {
  //   final user = FirebaseAuth.instance.currentUser;
  //   return FirebaseAuth.instance.authStateChanges().listen((user) async {
  //     if (user == null) {
  //       await FirebaseAuth.instance.signInAnonymously();
  //     } else {
  //       await InitializationService().createSample(user.uid);
  //     }
  //   });
  // }

  @override
  bool isLinked() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    return user.providerData
        .where((e) => e.providerId == EmailAuthProviderID)
        .isNotEmpty;
  }

  @override
  Future<void> signout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> withdrawal() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  @override
  Future<void> signinWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> linkWithEmailAndPassword(String email, String password) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  }

  @override
  Future<void> signin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
    } else {
      await InitializationService().createSample(user.uid);
    }
  }

  @override
  bool isLogin() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    }
    return true;
  }
}
