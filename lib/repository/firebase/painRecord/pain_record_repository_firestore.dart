import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';

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
    final QuerySnapshot<PainRecord> snapshot =
        await _getPainRecordsRefByUserID(userID)
            .orderBy('createdAt', descending: true)
            .get();

    final QuerySnapshot<BodyPart> bodyPartsSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .where('painRecordsID',
            whereIn: snapshot.docs.map((doc) => doc.id).toList())
        .withConverter<BodyPart>(
            fromFirestore: (snapshot, _) => BodyPart.fromJson(snapshot.data()!),
            toFirestore: (bodyPart, _) => bodyPart.toJson())
        .get();

    return snapshot.docs.map((painRecord) {
      painRecord.data().bodyParts = bodyPartsSnapshot.docs
          .where((element) => element.get('painRecordsID') == painRecord.id)
          .map((snapshot) => BodyPart(name: snapshot.get('name')))
          .toList();
      return painRecord.data();
    }).toList();
  }

  @override
  Future<List<PainRecord>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  void save(String userID, PainRecord painRecord) {
    (_getPainRecordsRefByUserID(userID)).add(painRecord);

    // painRecord.bodyParts!.map((bodyPart) =>
    //     (BodyPartsRepositoryFirestore.getBodyPartRefByUserID(userID))
    //         .add(bodyPart));
  }

  CollectionReference<PainRecord> _getPainRecordsRefByUserID(String userID) {
    final painRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) =>
                PainRecord.fromJson(snapshot.data()!),
            toFirestore: (painRecord, _) => painRecord.toJson());
    return painRecordsRef;
  }
}
