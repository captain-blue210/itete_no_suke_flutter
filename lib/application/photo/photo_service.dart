import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class PhotoService {
  final UserRepositoryInterface _userRepositoryInterface;
  final PhotoRepositoryInterface _photoRepositoryInterface;

  const PhotoService(
      this._userRepositoryInterface, this._photoRepositoryInterface);

  Stream<QuerySnapshot<Photo>> getPhotosByUserID() {
    return _photoRepositoryInterface
        .fetchPhotosByUserID(_userRepositoryInterface.getCurrentUser());
  }

  Future<void> addPhotos(List<XFile>? photos) async {
    for (var photo in photos!) {
      await _photoRepositoryInterface.save(
        _userRepositoryInterface.getCurrentUser(),
        File(photo.path),
      );
    }
  }

  void deletePhotos(List<Photo> photos) {
    for (var e in photos) {
      print("deletePhotos");
      _photoRepositoryInterface.delete(
          _userRepositoryInterface.getCurrentUser(),
          e.photoURL
              .substring(e.photoURL.lastIndexOf("%2F") + "%2F".length)
              .replaceAll(RegExp(r'\?.*$'), ""));
    }
  }
}
