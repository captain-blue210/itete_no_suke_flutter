import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';

class PhotoRepositoryStorageFirestore implements PhotoRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  PhotoRepositoryStorageFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
      FirebaseStorage.instance.useStorageEmulator(_localhost, 9199);
    }
  }

  @override
  Future<List<Photo>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<List<Photo>?> fetchPhotosByUserID(String userID) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .get();

    return snapshot.docs.map((doc) => Photo(doc)).toList();
  }
}
