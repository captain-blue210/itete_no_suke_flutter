import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/painRecord/pain_records.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/photo/photos.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/repository/firebase/bodyParts/body_parts_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/medicine/medicine_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/painRecord/pain_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/photo/photo_repository_storage_firestore.dart';
import 'package:itete_no_suke/repository/firebase/user/user_repository_mock.dart';
import 'package:itete_no_suke/view/pages/home.dart';
import 'package:path_provider/path_provider.dart';
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
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // DocumentReference ref = await users.add({
  //   'name': 'test',
  //   'iconURL': 'https://picsum.photos/250?image=9',
  //   'createdAt': FieldValue.serverTimestamp(),
  //   'updatedAt': FieldValue.serverTimestamp(),
  // });
  //
  // CollectionReference painRecords = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(ref.id)
  //     .collection('painRecords');
  // DocumentReference pRef = await painRecords.add({
  //   'userID': ref.id,
  //   'painLevel': 0,
  //   'memo': '記録メモ',
  //   'createdAt': FieldValue.serverTimestamp(),
  //   'updatedAt': FieldValue.serverTimestamp(),
  // });
  //
  // CollectionReference medicineRecords = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(ref.id)
  //     .collection('medicines');
  // await medicineRecords.add({
  //   'painRecordsID': pRef.id,
  //   'name': 'お薬1',
  //   'memo': 'メモ',
  //   'createdAt': FieldValue.serverTimestamp(),
  //   'updatedAt': FieldValue.serverTimestamp(),
  // });
  //
  // CollectionReference bodyPartRecords = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(ref.id)
  //     .collection('bodyParts');
  // await bodyPartRecords.add({
  //   'painRecordsID': pRef.id,
  //   'name': '部位1',
  //   'memo': 'メモ',
  //   'createdAt': FieldValue.serverTimestamp(),
  //   'updatedAt': FieldValue.serverTimestamp(),
  // });
  //
  CollectionReference photoRecords = FirebaseFirestore.instance
      .collection('users')
      .doc('p0HnEbeA3SVggtl9Ya8k')
      .collection('photos');
  await photoRecords.add({
    'painRecordsID': 'eicmQgdSRilVT4RejYbc',
    'photoURL':
        'http://localhost:9199/v0/b/itetenosuke-d40ae.appspot.com/o/users%2Fp0HnEbeA3SVggtl9Ya8k%2Fphotos%2F2532x1170.png?alt=media&token=c0de0b57-5da8-4d11-bc00-8e4956d6229a',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
  await photoRecords.add({
    'painRecordsID': 'eicmQgdSRilVT4RejYbc',
    'photoURL':
        'http://localhost:9199/v0/b/itetenosuke-d40ae.appspot.com/o/users%2Fp0HnEbeA3SVggtl9Ya8k%2Fphotos%2Ftest.png?alt=media&token=a07ab013-1a0f-41d7-b288-152776eb0018',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });

  File file1 = await getImageFileFromAssets('myicon2.jpg');
  await FirebaseStorage.instance
      .ref()
      .child('users')
      .child('p0HnEbeA3SVggtl9Ya8k')
      .child('icon')
      .child('myicon2.jpg')
      .putFile(file1);

  File file2 = await getImageFileFromAssets('2532x1170.png');
  await FirebaseStorage.instance
      .ref()
      .child('users')
      .child('p0HnEbeA3SVggtl9Ya8k')
      .child('photos')
      .child('2532x1170.png')
      .putFile(file2);

  File file3 = await getImageFileFromAssets('test.png');
  await FirebaseStorage.instance
      .ref()
      .child('users')
      .child('p0HnEbeA3SVggtl9Ya8k')
      .child('photos')
      .child('test.png')
      .putFile(file3);
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('images/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
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
        Provider<BodyPartsService>(
          create: (context) => BodyPartsService(
              context.read<UserRepositoryInterface>(),
              context.read<BodyPartsRepositoryInterface>()),
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
