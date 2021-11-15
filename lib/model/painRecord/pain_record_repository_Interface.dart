import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';

abstract class PainRecordRepositoryInterface {
  Future<List<PainRecord>> findAll();
  Future<List<PainRecord>?> fetchPainRecordsByUserID(String userID);
  Future<void> save(
    String userID,
    PainRecord painRecord,
    List<Medicine>? medicines,
    List<BodyPart>? bodyParts,
  );
  Future<List<Medicine>?> getMedicineByUserID(String userID);
  Future<List<BodyPart>?> getBodyPartsByUserID(String userID);
}
