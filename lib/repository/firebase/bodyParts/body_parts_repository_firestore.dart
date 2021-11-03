import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';

class BodyPartsRepositoryFirestore implements BodyPartsRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  BodyPartsRepositoryFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
    }
  }
  @override
  Future<List<BodyPart>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<List<BodyPart>?> fetchBodyPartsByUserID(String userID) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .get();

    return snapshot.docs.map((snapshot) => BodyPart(snapshot)).toList();
  }

  @override
  Future<List<BodyPart>?> fetchBodyPartsByPainRecordsID(
      String userID, String painRecordsID) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .where('painRecordsID', isEqualTo: painRecordsID)
        .get();
    return snapshot.docs.map((snapshot) => BodyPart(snapshot)).toList();
  }
}
