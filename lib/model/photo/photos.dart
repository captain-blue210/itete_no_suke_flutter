import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';

class Photos {
  final PhotoRepositoryInterface photoRepositoryInterface;

  const Photos({required this.photoRepositoryInterface});

  Future<List<Photo>> getPhotos() async {
    return await photoRepositoryInterface.findAll();
  }
}
