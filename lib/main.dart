import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/repository/bodyParts/body_parts_repository_mock.dart';
import 'package:itete_no_suke/view/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
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
          create: (context) => BodyPartsRepositoryMock(),
        ),
        Provider<BodyParts>(
          create: (context) => BodyParts(
              bodyRepository: context.read<BodyPartsRepositoryInterface>()),
        ),
        Provider<MedicineRepositoryInterface>(
          create: (context) => MedicineRepositoryMock(),
        ),
        Provider<Medicines>(
          create: (context) => Medicines(
              medicineRepository: context.read<MedicineRepositoryInterface>()),
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
