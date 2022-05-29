import 'package:itete_no_suke/model/bodyParts/body_part.dart';

abstract class BodyPartsRepositoryInterface {
  Future<List<BodyPart>> findAll();
  Stream<List<BodyPart>> fetchBodyPartsByUserID(String userID);
  Future<BodyPart> fetchBodyPartByID(String userID, String bodyPartsID);
  Future<List<BodyPart>> fetchBodyPartsByPainRecordsID(
      String userID, String painRecordsID);
  void save(String userID, BodyPart bodyPart);
  void update(String userID, BodyPart updated);
  void delete(String userID, String bodyPartsID);
}
