import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/application/user/user_service.dart';
import 'package:itete_no_suke/firebase_options.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/medicine/medicine_repository_interface.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/presentation/pages/home.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:itete_no_suke/presentation/request/photo/PhotoRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/auth/auth_state.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_state.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_mode_state.dart';
import 'package:itete_no_suke/repository/firebase/bodyParts/body_parts_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/medicine/medicine_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/painRecord/pain_record_repository_firestore.dart';
import 'package:itete_no_suke/repository/firebase/photo/photo_repository_storage_firestore.dart';
import 'package:itete_no_suke/repository/firebase/user/user_repository_firebase.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    host: 'localhost',
    persistenceEnabled: false,
    sslEnabled: false,
  );

  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const Init());
}

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  // late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    UserService userService = UserService(UserRepository());
    userService.signInAnonymously();
  }

  @override
  void dispose() {
    super.dispose();
    // user.cancel();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepositoryInterface>(
          create: (context) => UserRepository(),
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
        Provider<UserService>(
          create: (context) =>
              UserService(context.read<UserRepositoryInterface>()),
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
        ),
        ChangeNotifierProvider<PainRecordState>(
          create: (context) => PainRecordState(),
        ),
        ChangeNotifierProvider<AuthState>(
          create: (context) {
            var authstate = AuthState();
            authstate.loggedin(context.read<UserService>().isLogin());
            authstate.linked(context.read<UserService>().isLinked());
            return authstate;
          },
        ),
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
