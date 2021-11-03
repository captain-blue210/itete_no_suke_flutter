import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/painRecord/pain_records.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/photo/photos.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/repository/bodyParts/body_parts_repository_firestore.dart';
import 'package:itete_no_suke/repository/medicine/medicine_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/painRecord/pain_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/photo/photo_repository_storage_firestore.dart';
import 'package:itete_no_suke/repository/user/user_repository_mock.dart';
import 'package:itete_no_suke/view/pages/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseStorage.instance.useStorageEmulator('localhost', 9199);

  print('IS_EMULATOR : ${bool.fromEnvironment('IS_EMULATOR')}');
  // init data
  // await initData();

  runApp(const Init());
}

Future<void> initData() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentReference ref = await users.add({
    'name': 'test',
    'iconURL': 'https://picsum.photos/250?image=9',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  CollectionReference painRecords = FirebaseFirestore.instance
      .collection('users')
      .doc(ref.id)
      .collection('painRecords');
  DocumentReference pRef = await painRecords.add({
    'userID': ref.id,
    'painLevel': 0,
    'memo': '記録メモ',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  CollectionReference medicineRecords = FirebaseFirestore.instance
      .collection('users')
      .doc(ref.id)
      .collection('medicines');
  await medicineRecords.add({
    'painRecordsID': pRef.id,
    'name': 'お薬1',
    'memo': 'メモ',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  CollectionReference bodyPartRecords = FirebaseFirestore.instance
      .collection('users')
      .doc(ref.id)
      .collection('bodyParts');
  await bodyPartRecords.add({
    'painRecordsID': pRef.id,
    'name': '部位1',
    'memo': 'メモ',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  CollectionReference photoRecords = FirebaseFirestore.instance
      .collection('users')
      .doc(ref.id)
      .collection('photos');
  await photoRecords.add({
    'painRecordsID': pRef.id,
    'photoURL': 'https://picsum.photos/250?image=9',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepositoryInterface>(
          create: (context) => UserRepositoryMock(),
        ),
        Provider<BodyPartsRepositoryInterface>(
          create: (context) => BodyPartsRepositoryFirestore(),
        ),
        Provider<BodyParts>(
          create: (context) => BodyParts(
              bodyRepository: context.read<BodyPartsRepositoryInterface>()),
        ),
        Provider<MedicineRepositoryInterface>(
          create: (context) => MedicineRecordRepositoryFirestore(),
        ),
        Provider<MedicineService>(
          create: (context) => MedicineService(
              context.read<UserRepositoryInterface>(),
              context.read<MedicineRepositoryInterface>()),
        ),
        Provider<PainRecordRepositoryInterface>(
          create: (context) => PainRecordRepositoryFirestore(),
        ),
        Provider<PainRecords>(
          create: (context) => PainRecords(
              painRecordRepository:
                  context.read<PainRecordRepositoryInterface>()),
        ),
        Provider<PhotoRepositoryInterface>(
          create: (context) => PhotoRepositoryStorageFirestore(),
        ),
        Provider<Photos>(
          create: (context) => Photos(
              photoRepositoryInterface:
                  context.read<PhotoRepositoryInterface>()),
        )
      ],
      child: Itetenosuke(),
    );
  }
}

class Itetenosuke extends StatelessWidget {
  const Itetenosuke({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
