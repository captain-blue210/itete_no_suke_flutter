import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
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

  Stream<List<PainRecord>?> getPainRecordsByUserID() {
    return _painRecordRepository
        .fetchPainRecordsByUserID(_userRepositoryInterface.getCurrentUser());
  }

  Future<List<Medicine>?> getMedicinesByUserID() async {
    return await _painRecordRepository
        .getMedicineByUserID(_userRepositoryInterface.getCurrentUser());
  }

  Future<List<BodyPart>?> getBodyPartsByUserID() async {
    return await _painRecordRepository
        .getBodyPartsByUserID(_userRepositoryInterface.getCurrentUser());
  }

  Future<void> addPainRecord(PainRecordRequestParam param) async {
    await _painRecordRepository.save(
      _userRepositoryInterface.getCurrentUser(),
      PainRecord(
        painLevel: param.painLevel,
        memo: param.memo,
        createdAt: Timestamp.now().toDate(),
        updatedAt: Timestamp.now().toDate(),
      ),
      param.getMedicines(),
      param.getBodyParts(),
    );
  }

  Future<void> updatePainRecord(PainRecordRequestParam param) async {
    await _painRecordRepository.update(
      _userRepositoryInterface.getCurrentUser(),
      PainRecord(
        painRecordID: param.id,
        painLevel: param.painLevel,
        // memo: param.memo,
      ),
      param.getMedicines(),
      param.getBodyParts(),
    );
  }

  Future<PainRecord> getPainRecord(String painRecordID) async {
    return await _painRecordRepository.fetchPainRecordByID(
        _userRepositoryInterface.getCurrentUser(), painRecordID);
  }
}
