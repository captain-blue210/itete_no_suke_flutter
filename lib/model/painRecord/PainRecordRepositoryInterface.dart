import 'package:itetenosukte_flutter/model/painRecord/pain_record.dart';

abstract class PainRecordRepositoryInterface {
  Future<List<PainRecord>> findAll();
}
