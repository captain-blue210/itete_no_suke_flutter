import 'package:itete_no_suke/model/bodyParts/body_part.dart';

abstract class BodyPartsRepositoryInterface {
  Future<List<BodyPart>> findAll();
}
