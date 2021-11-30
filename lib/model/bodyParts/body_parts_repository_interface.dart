import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';

abstract class BodyPartsRepositoryInterface {
  Future<List<BodyPart>> findAll();
  Stream<QuerySnapshot<BodyPart>> fetchBodyPartsByUserID(String userID);
  Future<List<BodyPart>> fetchBodyPartsByPainRecordsID(
      String userID, String painRecordsID);
  void save(String userID, BodyPart bodyPart);
  void delete(String userID, String bodyPartsID);
}
