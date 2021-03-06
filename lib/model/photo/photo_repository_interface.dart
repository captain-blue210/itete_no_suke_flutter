import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

abstract class PhotoRepositoryInterface {
  Future<List<Photo>> findAll();
  Stream<List<Photo>> fetchPhotosByUserID(String userID);
  Future<DocumentReference<Photo>?> save(String userID, File image);
  void delete(String userID, Photo photo);
}
