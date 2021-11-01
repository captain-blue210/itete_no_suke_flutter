import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicines.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/painRecord/pain_records.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/photo/photos.dart';
import 'package:itete_no_suke/repository/bodyParts/body_parts_repository_firestore.dart';
import 'package:itete_no_suke/repository/medicine/medicine_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/painRecord/pain_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/photo/photo_repository_storage_firestore.dart';
import 'package:itete_no_suke/view/pages/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Init());
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
        Provider<Medicines>(
          create: (context) => Medicines(
              medicineRepository: context.read<MedicineRepositoryInterface>()),
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
