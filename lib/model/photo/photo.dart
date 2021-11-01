import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  late final DocumentReference photoRef;
  late final String painRecordsID;
  late final String photoURL;

  Photo(DocumentSnapshot doc) {
    photoRef = doc.reference;
    painRecordsID = doc['painRecordsID'];
    photoURL = doc['photoURL'];
  }
}
