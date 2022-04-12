import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/model/photo/photo_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';

class PainRecordsService {
  final UserRepositoryInterface _userRepositoryInterface;
  final PainRecordRepositoryInterface _painRecordRepository;
  final PhotoRepositoryInterface _photoRepositoryInterface;

  const PainRecordsService(
    userRepositoryInterface,
    PainRecordRepositoryInterface painRecordRepository,
    PhotoRepositoryInterface photoRepository,
  )   : _userRepositoryInterface = userRepositoryInterface,
        _painRecordRepository = painRecordRepository,
        _photoRepositoryInterface = photoRepository;

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
        memo: param.memo,
      ),
      param.getMedicines(),
      param.getBodyParts(),
      param.getPhotos(),
    );
  }

  Future<PainRecord> getPainRecord(String painRecordID) {
    return _painRecordRepository.fetchPainRecordByID(
        _userRepositoryInterface.getCurrentUser(), painRecordID);
  }

  Future<void> deletePainRecordPhotos(PainRecordRequestParam param) async {
    await _painRecordRepository.deletePainRecordPhotos(
        _userRepositoryInterface.getCurrentUser(),
        param.id!,
        param.getPhotos()!);

    for (var photo in param.getPhotos()!) {
      if (photo.deleted!) {
        _photoRepositoryInterface.delete(
            _userRepositoryInterface.getCurrentUser(), photo);
      }
    }
  }

  Future<void> addPainRecordPhotos(PainRecordRequestParam param) async {
    List<Photo> photos = <Photo>[];
    for (var image in param.getPhotos()!) {
      var ref = await _photoRepositoryInterface.save(
          _userRepositoryInterface.getCurrentUser(), File(image.image!.path));
      // 上記のrefを登録したphotoを作成する
      // users > painrecords > photosに登録する
      photos.add(image.copyWith(ref: ref));
    }

    await _painRecordRepository.addPainRecordPhotos(
        _userRepositoryInterface.getCurrentUser(), param.id!, photos);
  }
}
