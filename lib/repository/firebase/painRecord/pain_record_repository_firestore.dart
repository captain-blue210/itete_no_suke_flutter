import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

class PainRecordRepositoryFirestore implements PainRecordRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  PainRecordRepositoryFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
    }
  }

  @override
  Stream<List<PainRecord>?> fetchPainRecordsByUserID(String userID) async* {
    var painRecordsStream = _getPainRecordsRefByUserID(userID)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots(includeMetadataChanges: true);

    // print('fetchPainRecordsByUserID : ${await painRecordsStream.length}');
    var painRecords = <PainRecord>[];
    await for (var painRecordSnapshot in painRecordsStream) {
      for (var painRecordSnapshot in painRecordSnapshot.docs) {
        // 同じIDがあればskip
        if (_existSameID(painRecordSnapshot.id, painRecords)) {
          continue;
        }
        var bodyPartSnapshot =
            await _getBodyPartsRefByPainRecordID(userID, painRecordSnapshot.id);
        painRecords
            .add(painRecordSnapshot.data().setBodyParts(bodyPartSnapshot));
      }
      yield painRecords;
    }
  }

  bool _existSameID(String id, List<PainRecord> target) {
    for (var painRecord in target) {
      if (painRecord.getPainRecordID == id) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<List<PainRecord>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<void> save(
    String userID,
    PainRecord painRecord,
    List<Medicine>? medicines,
    List<BodyPart>? bodyParts,
  ) async {
    String painRecordsID = await (_getPainRecordsRefByUserID(userID))
        .add(painRecord)
        .then((ref) => ref.id);

    for (var e in medicines!) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('painRecords')
          .doc(painRecordsID)
          .collection('medicines')
          .add({'medicineRef': e.medicineRef});
    }

    for (var e in bodyParts!) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('painRecords')
          .doc(painRecordsID)
          .collection('bodyParts')
          .add({'bodyPartRef': e.bodyPartRef});
    }
  }

  CollectionReference<PainRecord> _getPainRecordsRefByUserID(String userID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) {
              if (!snapshot.metadata.hasPendingWrites) {
                return PainRecord.fromJson(snapshot.id, snapshot.data()!);
              } else {
                var updated = snapshot.data()!.map((key, value) => MapEntry(
                    key, key == "updatedAt" ? Timestamp.now() : value));
                return PainRecord.fromJson(snapshot.id, updated);
              }
            },
            toFirestore: (painRecord, _) => painRecord.toJson());
  }

  DocumentReference<PainRecord> _getPainRecordsRefByID(
      String userID, String painRecordID) {
    final painRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecordID)
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) =>
                PainRecord.fromJson(snapshot.id, snapshot.data()!),
            toFirestore: (painRecord, _) => painRecord.toJson());
    return painRecordsRef;
  }

  DocumentReference<BodyPart> _getBodyPartsRef(
      String userID, String bodyPartID) {
    var bodyPartsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bodyParts')
        .doc(bodyPartID)
        .withConverter<BodyPart>(
            fromFirestore: (snapshot, _) => BodyPart.fromJson(snapshot.data()!),
            toFirestore: (bodyPart, _) => bodyPart.toJson());
    return bodyPartsRef;
  }

  Future<BodyPart> _getBodyPart(
      String userID, BodyPart painRecordBodyPart) async {
    final bodyPart =
        (await _getBodyPartsRef(userID, painRecordBodyPart.id!).get()).data()!;
    return painRecordBodyPart.copyWith(
        name: bodyPart.name, memo: bodyPart.memo);
  }

  Future<List<BodyPart>> _getBodyPartsRefByPainRecordID(
      String userID, String painRecordID) async {
    final painRecordBodyParts = (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('painRecords')
            .doc(painRecordID)
            .collection('bodyParts')
            .withConverter<BodyPart>(
              fromFirestore: (snapshot, _) =>
                  BodyPart.fromJson(snapshot.data()!).copyWith(
                      id: snapshot.data()!['bodyPartRef'].id,
                      painRecordBodyPartId: snapshot.id,
                      ref: _getBodyPartsRef(
                          userID, snapshot.data()!['bodyPartRef'].id)),
              toFirestore: (bodyPart, _) => bodyPart.toJson(),
            )
            .get())
        .docs;

    var result = <BodyPart>[];
    for (var item in painRecordBodyParts) {
      result.add(await _getBodyPart(userID, item.data()));
    }
    return result;
  }

  DocumentReference<Medicine> _getMedicinesRef(
      String userID, String medicineID) {
    final medicinesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('medicines')
        .doc(medicineID)
        .withConverter<Medicine>(
          fromFirestore: (snapshot, _) => Medicine.fromJson(snapshot.data()!),
          toFirestore: (medicine, _) => medicine.toJson(),
        );
    return medicinesRef;
  }

  Future<Medicine> _getMedicine(
      String userID, Medicine painRecordMedicine) async {
    final medicine =
        (await _getMedicinesRef(userID, painRecordMedicine.id!).get()).data()!;
    return painRecordMedicine.copyWith(
        name: medicine.name, memo: medicine.memo);
  }

  Future<List<Medicine>> _getMedicinesRefByPainRecordID(
      String userID, String painRecordID) async {
    // painrecords/medicines配下を取り出す
    // medicineRef
    final painRecordMedicines = (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection("painRecords")
            .doc(painRecordID)
            .collection('medicines')
            .withConverter<Medicine>(
              fromFirestore: (snapshot, _) =>
                  Medicine.fromJson(snapshot.data()!).copyWith(
                      id: snapshot.data()!['medicineRef'].id,
                      painRecordMedicineId: snapshot.id,
                      ref: _getMedicinesRef(
                          userID, snapshot.data()!['medicineRef'].id)),
              toFirestore: (medicine, _) => medicine.toJson(),
            )
            .get())
        .docs;

    var result = <Medicine>[];
    for (var item in painRecordMedicines) {
      var medicine = await _getMedicine(userID, item.data());
      result.add(medicine);
    }
    return result;
  }

  @override
  Future<List<Medicine>?> getMedicineByUserID(String userID) async {
    return (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('medicines')
            .withConverter<Medicine>(
              fromFirestore: (snapshot, _) {
                var medicine = Medicine.fromJson(snapshot.data()!);
                medicine.id = snapshot.id;
                return medicine.copyWith(
                    ref: _getMedicinesRef(userID, snapshot.id));
              },
              toFirestore: (medicine, _) => medicine.toJson(),
            )
            .get())
        .docs
        .map((e) => e.data())
        .toList();
  }

  @override
  Future<List<BodyPart>?> getBodyPartsByUserID(String userID) async {
    return (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('bodyParts')
            .withConverter<BodyPart>(
              fromFirestore: (snapshot, _) =>
                  BodyPart.fromJson(snapshot.data()!).copyWith(
                      id: snapshot.id,
                      ref: _getBodyPartsRef(userID, snapshot.id)),
              toFirestore: (bodyPart, _) => bodyPart.toJson(),
            )
            .get())
        .docs
        .map((e) => e.data())
        .toList();
  }

  DocumentReference<Photo> _getPhotosRef(String userID, String photoID) {
    final photosRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .doc(photoID)
        .withConverter<Photo>(
          fromFirestore: (snapshot, _) => Photo.fromJson(snapshot.data()!),
          toFirestore: (photo, _) => photo.toJson(),
        );
    return photosRef;
  }

  Future<Photo> _getPhoto(String userID, Photo painRecordPhoto) async {
    final photo =
        (await _getPhotosRef(userID, painRecordPhoto.id!).get()).data()!;
    return painRecordPhoto.copyWith(photoURL: photo.photoURL);
  }

  Future<List<Photo>?> _getPhotosRefByPainRecordID(
      String userID, String painRecordID) async {
    final painRecordPhotos = (await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('painRecords')
            .doc(painRecordID)
            .collection('photos')
            .withConverter<Photo>(
              fromFirestore: (snapshot, _) {
                print(snapshot.data()!['photoRef'].id);
                return Photo.fromJson(snapshot.data()!).copyWith(
                  id: snapshot.data()!['photoRef'].id,
                  painRecordPhotoId: snapshot.id,
                  ref: _getPhotosRef(userID, snapshot.data()!['photoRef'].id),
                  deleted: false,
                );
              },
              toFirestore: (photo, _) => photo.toJson(),
            )
            .get())
        .docs
        .map((e) => e.data())
        .toList();

    var result = <Photo>[];
    for (var item in painRecordPhotos) {
      result.add(await _getPhoto(userID, item));
    }
    return result;
  }

  @override
  Future<PainRecord> fetchPainRecordByID(
      String userID, String painRecordID) async {
    var painRecord = await _getPainRecordsRefByID(userID, painRecordID).get();

    var medicines = await _getMedicinesRefByPainRecordID(userID, painRecordID);
    var bodyParts = await _getBodyPartsRefByPainRecordID(userID, painRecordID);
    var photos = await _getPhotosRefByPainRecordID(userID, painRecordID);

    return painRecord
        .data()!
        .setMedicines(medicines)
        .setBodyParts(bodyParts)
        .setPhotos(photos);
  }

  @override
  Future<void> update(
      String userID,
      PainRecord painRecord,
      List<Medicine>? medicines,
      List<BodyPart>? bodyParts,
      List<Photo>? photos) async {
    _getPainRecordsRefByID(userID, painRecord.getPainRecordID!).update({
      'painLevel': painRecord.painLevel.index,
      'memo': painRecord.memo,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    if (medicines!.isNotEmpty) {
      for (var medicine in medicines) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('painRecords')
            .doc(painRecord.getPainRecordID)
            .collection('medicines')
            .doc(medicine.painRecordMedicineId)
            .update({'medicineRef': medicine.medicineRef});
      }
    }

    if (bodyParts!.isNotEmpty) {
      for (var bodypart in bodyParts) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('painRecords')
            .doc(painRecord.getPainRecordID)
            .collection('bodyParts')
            .doc(bodypart.painRecordBodyPartId)
            .update({'bodyPartRef': bodypart.bodyPartRef});
      }
    }
  }

  @override
  Future<void> deletePainRecordPhotos(
      String userID, String painRecordID, List<Photo> photos) async {
    for (var photo in photos) {
      print('photo pid: ${photo.painRecordPhotoId}');
      if (photo.deleted!) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('painRecords')
            .doc(painRecordID)
            .collection('photos')
            .doc(photo.painRecordPhotoId)
            .delete();
      }
    }
  }

  @override
  Future<void> addPainRecordPhotos(
      String userID, String painRecordID, List<Photo> photos) async {
    for (var photo in photos) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('painRecords')
          .doc(painRecordID)
          .collection('photos')
          .add({
        'photoRef': photo.photoRef,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
