import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itete_no_suke/application/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/presentation/pages/home.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:itete_no_suke/presentation/request/photo/PhotoRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_mode_state.dart';
import 'package:itete_no_suke/repository/firebase/bodyParts/body_parts_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/medicine/medicine_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/painRecord/pain_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/photo/photo_repository_storage_firestore.dart';
import 'package:itete_no_suke/repository/firebase/user/user_repository_mock.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    host: 'localhost',
    sslEnabled: false,
  );

  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseStorage.instance.useStorageEmulator('localhost', 9199);

  print('IS_EMULATOR : ${bool.fromEnvironment('IS_EMULATOR')}');
  // init data
  // await initData();

  runApp(const Init());
}

Future<void> initData() async {
  try {
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
    DocumentReference mRef = await medicineRecords.add({
      'painRecordsID': pRef.id,
      'name': 'お薬1',
      'memo': 'メモ',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    DocumentReference mRef2 = await medicineRecords.add({
      'painRecordsID': pRef.id,
      'name': 'お薬2',
      'memo': 'メモ',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    DocumentReference mRef3 = await medicineRecords.add({
      'painRecordsID': pRef.id,
      'name': 'お薬3',
      'memo': 'メモ',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    CollectionReference bodyPartRecords = FirebaseFirestore.instance
        .collection('users')
        .doc(ref.id)
        .collection('bodyParts');

    DocumentReference bRef = await bodyPartRecords.add({
      'painRecordsID': pRef.id,
      'name': '部位1',
      'memo': 'メモ',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    DocumentReference bRef2 = await bodyPartRecords.add({
      'painRecordsID': pRef.id,
      'name': '部位2',
      'memo': 'メモ',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    DocumentReference bRef3 = await bodyPartRecords.add({
      'painRecordsID': pRef.id,
      'name': '部位3',
      'memo': 'メモ',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    File file1 = await getImageFileFromAssets('myicon2.jpg');
    final result1 = await FirebaseStorage.instance
        .ref()
        .child('users')
        .child(ref.id)
        .child('icon')
        .child('myicon2.jpg')
        .putFile(file1);

    File file2 = await getImageFileFromAssets('2532x1170.png');
    final result2 = await FirebaseStorage.instance
        .ref()
        .child('users')
        .child(ref.id)
        .child('photos')
        .child('2532x1170.png')
        .putFile(file2);

    File file3 = await getImageFileFromAssets('test.png');
    final result3 = await FirebaseStorage.instance
        .ref()
        .child('users')
        .child(ref.id)
        .child('photos')
        .child('test.png')
        .putFile(file3);

    CollectionReference photoRecords = FirebaseFirestore.instance
        .collection('users')
        .doc(ref.id)
        .collection('photos');

    final url1 = await result1.ref.getDownloadURL();
    final url2 = await result2.ref.getDownloadURL();
    final url3 = await result3.ref.getDownloadURL();

    DocumentReference pRef1 = await photoRecords.add({
      'photoURL': url1,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    DocumentReference pRef2 = await photoRecords.add({
      'photoURL': url2,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    DocumentReference pRef3 = await photoRecords.add({
      'photoURL': url3,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    painRecords.doc(pRef.id).collection('medicines').add({
      'medicineRef': mRef,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    painRecords.doc(pRef.id).collection('medicines').add({
      'medicineRef': mRef2,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    painRecords.doc(pRef.id).collection('medicines').add({
      'medicineRef': mRef3,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    painRecords.doc(pRef.id).collection('bodyParts').add({
      'bodyPartRef': bRef,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    painRecords.doc(pRef.id).collection('bodyParts').add({
      'bodyPartRef': bRef2,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    painRecords.doc(pRef.id).collection('bodyParts').add({
      'bodyPartRef': bRef3,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    painRecords.doc(pRef.id).collection('photos').add({
      'photoRef': pRef1,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    painRecords.doc(pRef.id).collection('photos').add({
      'photoRef': pRef2,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    painRecords.doc(pRef.id).collection('photos').add({
      'photoRef': pRef3,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  } on Exception catch (e) {}
}

// TODO あとで削除
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
        Provider<PhotoRepositoryInterface>(
          create: (context) => PhotoRepositoryStorageFirestore(),
        ),
        Provider<PainRecordsService>(
            create: (context) => PainRecordsService(
                context.read<UserRepositoryInterface>(),
                context.read<PainRecordRepositoryInterface>(),
                context.read<PhotoRepositoryInterface>())),
        Provider<PhotoService>(
          create: (context) => PhotoService(
              context.read<UserRepositoryInterface>(),
              context.read<PhotoRepositoryInterface>()),
        ),
        ChangeNotifierProvider<PainRecordRequestParam>(
          create: (_) => PainRecordRequestParam(),
        ),
        ChangeNotifierProvider<PhotoModeState>(
          create: (context) => PhotoModeState(),
        ),
        ChangeNotifierProvider<PhotoRequestParam>(
          create: (context) => PhotoRequestParam(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<PainRecordsService>().getPainRecordsByUserID(),
          initialData: const <PainRecord>[],
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
