import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  late final DocumentReference medicineRef;
  late final String painRecordsID;
  late final String name;
  late final String memo;

  Medicine(DocumentSnapshot doc) {
    medicineRef = doc.reference;
    painRecordsID = doc['painRecordsID'];
    name = doc['name'];
    memo = doc['memo'];
  }
}
