import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';

class PainRecordsService {
  final UserRepositoryInterface _userRepositoryInterface;
  final PainRecordRepositoryInterface _painRecordRepository;

  const PainRecordsService(
    userRepositoryInterface,
    PainRecordRepositoryInterface painRecordRepository,
  )   : _userRepositoryInterface = userRepositoryInterface,
        _painRecordRepository = painRecordRepository;

  Future<List<PainRecord>?> getPainRecordsByUserID(String userID) async {
    return await _painRecordRepository.fetchPainRecordsByUserID(userID);
  }

  Future<List<Medicine>?> getMedicinesByUserID(String userID) async {
    return await _painRecordRepository.getMedicineByUserID(userID);
  }

  Future<void> addPainRecord(PainRecordRequestParam param) async {
    await _painRecordRepository.save(
      _userRepositoryInterface.getCurrentUser(),
      PainRecord(painLevel: param.painLevel).setMedicineSet(
        param.getMedicineSet(),
      ),
    );
  }
}
