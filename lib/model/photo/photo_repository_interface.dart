import 'package:itete_no_suke/model/photo/photo.dart';

abstract class PhotoRepositoryInterface {
  Future<List<Photo>> findAll();
  Future<List<Photo>?> fetchPhotosByUserID(String userID);
}
