import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';

class PainRecords {
  final PainRecordRepositoryInterface painRecordRepository;

  const PainRecords({required this.painRecordRepository});

  Future<List<PainRecord>?> getPainRecordsByUserID(String userID) async {
    return await painRecordRepository.fetchPainRecordsByUserID(userID);
  }
}
