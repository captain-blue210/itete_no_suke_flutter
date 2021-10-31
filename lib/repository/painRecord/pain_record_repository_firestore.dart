import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/painRecord/PainRecordRepositoryInterface.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';

class PainRecordRepositoryFirestore implements PainRecordRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  PainRecordRepositoryFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
    }
  }

  @override
  Future<List<PainRecord>?> fetchPainRecordsByUserID(String userID) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .get();

    final QuerySnapshot bodyPartsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .where('painRecordsID',
            whereIn: snapshot.docs.map((doc) => doc.id).toList())
        .get();

    return snapshot.docs.map((doc) {
      var painRecord = PainRecord(doc);
      painRecord.bodyParts = bodyPartsSnapshot.docs
          .where((element) => element.get('painRecordsID') == doc.id)
          .map((e) => BodyPart(e))
          .toList();
      return painRecord;
    }).toList();
  }

  @override
  Future<List<PainRecord>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }
}
