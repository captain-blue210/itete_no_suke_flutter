import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class PhotoService {
  final UserRepositoryInterface _userRepositoryInterface;
  final PhotoRepositoryInterface _photoRepositoryInterface;

  const PhotoService(
      this._userRepositoryInterface, this._photoRepositoryInterface);

  Future<void> addPhotos(List<XFile>? photos) async {
    for (var photo in photos!) {
      await _photoRepositoryInterface.save(
        _userRepositoryInterface.getCurrentUser(),
        File(photo.path),
      );
    }
  }
}
