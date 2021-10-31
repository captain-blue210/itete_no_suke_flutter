import 'package:cloud_firestore/cloud_firestore.dart';

class BodyPart {
  late final DocumentReference bodyPartRef;
  late final String painRecordsID;
  late final String name;
  late final String memo;

  BodyPart(DocumentSnapshot doc) {
    bodyPartRef = doc.reference;
    painRecordsID = doc['painRecordsID'];
    name = doc['name'];
    memo = doc['memo'];
  }
}
