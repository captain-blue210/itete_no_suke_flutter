import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';

class BodyParts {
  final BodyPartsRepositoryInterface bodyRepository;

  const BodyParts({required this.bodyRepository});

  Future<List<BodyPart>> getBodyParts() async {
    return await bodyRepository.findAll();
  }

  Future<int> getCounts() async {
    return await bodyRepository
        .findAll()
        .then((bodyPartsList) => bodyPartsList.length);
  }
}
