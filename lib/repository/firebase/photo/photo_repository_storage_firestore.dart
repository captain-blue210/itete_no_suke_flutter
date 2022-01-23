import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:uuid/uuid.dart';

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
  Stream<QuerySnapshot<Photo>> fetchPhotosByUserID(String userID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .withConverter<Photo>(
          fromFirestore: (snapshot, _) {
            Photo photo = Photo.fromJson(snapshot.data()!);
            photo.photoID = snapshot.id;
            return photo;
          },
          toFirestore: (photo, _) => photo.toJson(),
        )
        .snapshots();
  }

  @override
  Future<void> save(String userID, File image) async {
    try {
      final result = await FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('photos')
          .child('${const Uuid().v4()}.${image.path.split('.')[1]}')
          .putFile(image);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('photos')
          .add({
        'painRecordsID': '',
        'photoURL': await result.ref.getDownloadURL(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp()
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void delete(String userID, Photo photo) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('photos')
          .doc(photo.photoID)
          .delete();

      FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('photos')
          .child(photo.photoURL
              .substring(photo.photoURL.lastIndexOf("%2F") + "%2F".length)
              .replaceAll(RegExp(r'\?.*$'), ""))
          .delete();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
