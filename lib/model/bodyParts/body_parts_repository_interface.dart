import 'package:itetenosukte_flutter/model/bodyParts/body_part.dart';

abstract class BodyPartsRepositoryInterface {
  Future<List<BodyPart>> findAll();
}
