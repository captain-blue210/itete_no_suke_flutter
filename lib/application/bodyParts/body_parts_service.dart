import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class BodyPartsService {
  final UserRepositoryInterface _userRepositoryInterface;
  final BodyPartsRepositoryInterface _bodyPartsRepositoryInterface;

  const BodyPartsService(
      this._userRepositoryInterface, this._bodyPartsRepositoryInterface);

  Stream<QuerySnapshot<BodyPart>> getBodyPartsByUserID() {
    return _bodyPartsRepositoryInterface
        .fetchBodyPartsByUserID(_userRepositoryInterface.getCurrentUser());
  }

  Future<List<BodyPart>?> getBodyPartsByPainRecordsID(
      String userID, String painRecordsID) async {
    return await _bodyPartsRepositoryInterface.fetchBodyPartsByPainRecordsID(
        userID, painRecordsID);
  }

  void addNewBodyPart(BodyPart bodyPart) {
    _bodyPartsRepositoryInterface.save(
        _userRepositoryInterface.getCurrentUser(), bodyPart);
  }

  void deleteBodyPart(String bodyPartsID) {
    _bodyPartsRepositoryInterface.delete(
        _userRepositoryInterface.getCurrentUser(), bodyPartsID);
  }
}
