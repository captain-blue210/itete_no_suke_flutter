import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:path_provider/path_provider.dart';

class InitializationService {
  Future<void> createSample(String userID) async {
    var userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

    if (userDoc.exists) return;

    await userDoc.reference.set({
      'name': 'おためしユーザー',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    CollectionReference painRecords = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords');

    var painRecord = await painRecords.add({
      'userID': userID,
      'painLevel': PainLevel.noPain.index,
      'memo': 'お薬や痛む部位以外に気になることをメモできます。',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    var medicines = await _createSample(userID, 'medicines', 'お薬サンプル');
    var bodyparts = await _createSample(userID, 'bodyParts', 'いたいところサンプル');
    var photos = await _createSampleImages(userID);

    _addSampleDataToPainRecord(
        painRecords, painRecord.id, 'medicines', medicines);
    _addSampleDataToPainRecord(
        painRecords, painRecord.id, 'bodyParts', bodyparts);
    _addSampleDataToPainRecord(painRecords, painRecord.id, 'photos', photos);
  }

  Future<List<DocumentReference>> _createSample(
      String userID, String collection, String baseName) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection(collection);

    var result = <DocumentReference>[];
    for (var i = 5; i >= 1; i--) {
      DocumentReference docRef = await collectionRef.add({
        'name': '$baseName${i.toString()}',
        'memo': 'メモを書くことができます。',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      result.add(docRef);
    }
    return result;
  }

  Future<List<DocumentReference>> _createSampleImages(String userID) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos');

    var result = <DocumentReference>[];
    for (var i = 1; i <= 3; i++) {
      final fileName = 'sample${i.toString()}.png';
      final uploaded = await FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('photos')
          .child(fileName)
          .putFile(await _getImageFileFromAssets(fileName));

      final url = await uploaded.ref.getDownloadURL();
      final docRef = await collectionRef.add({
        'photoURL': url,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      result.add(docRef);
    }
    return result;
  }

  Future<File> _getImageFileFromAssets(String fileName) async {
    final byteData = await rootBundle.load('images/$fileName');

    final file = File('${(await getTemporaryDirectory()).path}/$fileName');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void _addSampleDataToPainRecord(CollectionReference painRecordRef,
      String painRecordID, String collection, List<DocumentReference> data) {
    for (var docRef in data) {
      painRecordRef.doc(painRecordID).collection(collection).add({
        '${collection.substring(0, collection.length - 1)}Ref': docRef,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
