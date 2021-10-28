import 'package:itete_no_suke/model/painRecord/pain_record.dart';

abstract class PainRecordRepositoryInterface {
  Future<List<PainRecord>> findAll();
}
