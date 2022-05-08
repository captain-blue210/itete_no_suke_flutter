import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_repository_interface.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class BodyPartsService {
  final UserRepositoryInterface _userRepositoryInterface;
  final BodyPartsRepositoryInterface _bodyPartsRepositoryInterface;

  const BodyPartsService(
      this._userRepositoryInterface, this._bodyPartsRepositoryInterface);

  Stream<List<BodyPart>> getBodyPartsByUserID() {
    if (_userRepositoryInterface.getCurrentUser() == '') {
      return const Stream.empty();
    }
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

  void updateBodyPart(BodyPart updated) {
    _bodyPartsRepositoryInterface.update(
        _userRepositoryInterface.getCurrentUser(), updated);
  }

  Future<BodyPart> getBodyPart(String bodyPartsID) async =>
      await _bodyPartsRepositoryInterface.fetchBodyPartByID(
          _userRepositoryInterface.getCurrentUser(), bodyPartsID);

  void deleteBodyPart(String bodyPartsID) {
    _bodyPartsRepositoryInterface.delete(
        _userRepositoryInterface.getCurrentUser(), bodyPartsID);
  }
}
