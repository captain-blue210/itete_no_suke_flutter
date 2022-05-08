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
    if (_userRepositoryInterface.getCurrentUser() == '') {
      return const Stream.empty();
    }
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
    for (var photo in photos) {
      _photoRepositoryInterface.delete(
          _userRepositoryInterface.getCurrentUser(), photo);
    }
  }
}
