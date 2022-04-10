import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

abstract class PainRecordRepositoryInterface {
  Future<List<PainRecord>> findAll();
  Stream<List<PainRecord>?> fetchPainRecordsByUserID(String userID);
  Future<void> save(
    String userID,
    PainRecord painRecord,
    List<Medicine>? medicines,
    List<BodyPart>? bodyParts,
  );
  Future<List<Medicine>?> getMedicineByUserID(String userID);
  Future<List<BodyPart>?> getBodyPartsByUserID(String userID);
  Future<PainRecord> fetchPainRecordByID(String userID, String painRecordID);
  Future<void> update(
    String userID,
    PainRecord painRecord,
    List<Medicine>? medicines,
    List<BodyPart>? bodyParts,
    List<Photo>? photos,
  );
}
