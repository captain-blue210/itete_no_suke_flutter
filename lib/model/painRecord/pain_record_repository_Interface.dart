import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';

abstract class PainRecordRepositoryInterface {
  Future<List<PainRecord>> findAll();
  Future<List<PainRecord>?> fetchPainRecordsByUserID(String userID);
  Future<void> save(String userID, PainRecord painRecord);
  Future<List<Medicine>?> getMedicineByUserID(String userID);
}
