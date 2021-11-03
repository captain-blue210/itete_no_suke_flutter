import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itete_no_suke/main.dart';

Future<void> main() async {
  testWidgets('Firestore emulator test', (WidgetTester tester) async {
    await tester.pumpWidget(const Init());

    const localhost = 'localhost';
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'name': 'test',
      'iconURL': 'https://picsum.photos/250?image=9',
      'createdAt': '',
      'updatedAt': '',
      'painRecords': {}
    });
  });
}
