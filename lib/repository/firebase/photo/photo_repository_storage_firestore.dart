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
  Stream<List<Photo>> fetchPhotosByUserID(String userID) async* {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .withConverter<Photo>(
          fromFirestore: (snapshot, _) =>
              Photo.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (photo, _) => photo.toJson(),
        )
        .orderBy('createdAt', descending: true)
        .snapshots();
    var photos = <Photo>[];
    await for (var snapshot in stream) {
      for (var photo in snapshot.docs) {
        photos.add(photo.data());
      }
      yield photos;
    }
  }

  @override
  Future<DocumentReference<Photo>?> save(String userID, File image) async {
    DocumentReference<Photo> ref;
    try {
      final result = await FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('photos')
          .child('${const Uuid().v4()}.${image.path.split('.')[1]}')
          .putFile(image);

      ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('photos')
          .withConverter<Photo>(
            fromFirestore: (snapshot, _) =>
                Photo.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
            toFirestore: (photo, _) => photo.toJson(),
          )
          .add(Photo(
              photoURL: await result.ref.getDownloadURL(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()));
      return ref;
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
          .doc(photo.id)
          .delete();

      FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('photos')
          .child(photo.photoURL!
              .substring(photo.photoURL!.lastIndexOf("%2F") + "%2F".length)
              .replaceAll(RegExp(r'\?.*$'), ""))
          .delete();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
