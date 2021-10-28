import 'package:itetenosukte_flutter/model/painRecord/PainRecordRepositoryInterface.dart';
import 'package:itetenosukte_flutter/model/painRecord/pain_record.dart';

class PainRecords {
  final PainRecordRepositoryInterface painRecordRepository;

  const PainRecords({required this.painRecordRepository});

  Future<List<PainRecord>> getPainRecords() async {
    return await painRecordRepository.findAll();
  }
}
