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
  Stream<QuerySnapshot<BodyPart>> fetchBodyPartsByUserID(String userID) {
    return getBodyPartRefByUserID(userID)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Future<List<BodyPart>> fetchBodyPartsByPainRecordsID(
      String userID, String painRecordsID) async {
    return _getBodyPartRefByPainRecordsID(userID, painRecordsID).get().then(
        (snapshot) =>
            snapshot.docs.map((e) => BodyPart(name: e.data().name)).toList());
  }

  @override
  void save(String userID, BodyPart bodyPart) {
    (getBodyPartRefByUserID(userID)).add(bodyPart);
  }

  static CollectionReference<BodyPart> getBodyPartRefByUserID(String userID) {
    final bodyPartsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .withConverter<BodyPart>(
            fromFirestore: (snapshot, _) => BodyPart.fromJson(snapshot.data()!),
            toFirestore: (bodyPart, _) => bodyPart.toJson());
    return bodyPartsRef;
  }

  Query<BodyPart> _getBodyPartRefByPainRecordsID(
      String userID, String painRecordsID) {
    final bodyPartsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .where('painRecordsID', isEqualTo: painRecordsID)
        .withConverter<BodyPart>(
            fromFirestore: (snapshot, _) => BodyPart.fromJson(snapshot.data()!),
            toFirestore: (bodyPart, _) => bodyPart.toJson());
    return bodyPartsRef;
  }

  DocumentReference<BodyPart> getBodyPartRefByID(
      String userID, String bodyPartsID) {
    final bodyPartsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .doc(bodyPartsID)
        .withConverter<BodyPart>(
            fromFirestore: (snapshot, _) => BodyPart.fromJson(snapshot.data()!),
            toFirestore: (bodyPart, _) => bodyPart.toJson());
    return bodyPartsRef;
  }

  @override
  void delete(String userID, String bodyPartsID) {
    getBodyPartRefByID(userID, bodyPartsID).delete();
  }

  @override
  void update(String userID, BodyPart updated) {
    getBodyPartRefByID(userID, updated.bodyPartsID).update(updated.toJson());
  }

  @override
  Future<BodyPart> fetchBodyPartByID(String userID, String bodyPartsID) async {
    return getBodyPartRefByID(userID, bodyPartsID).get().then(
        (bodyPart) => bodyPart.data()!.setBodyPartRef(bodyPart.reference));
  }
}
