import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_record_repository_Interface.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:uuid/uuid.dart';

class PainRecordRepositoryFirestore implements PainRecordRepositoryInterface {
  static const _localhost = 'localhost';
  static const _isEmulator = bool.fromEnvironment('IS_EMULATOR');

  PainRecordRepositoryFirestore() {
    if (_isEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator(_localhost, 8080);
    }
  }

  @override
  Stream<List<PainRecord>> fetchPainRecordsByUserID(String userID) async* {
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
    List<Photo>? photos,
  ) async {
    String painRecordID = await (_getPainRecordsRefByUserID(userID))
        .add(painRecord)
        .then((ref) => ref.id);

    for (var medicine in medicines!) {
      await addMedicine(medicine, userID, painRecordID);
    }

    for (var bodyPart in bodyParts!) {
      await addBodypart(bodyPart, userID, painRecordID);
    }

    var painRecordPhotos = <Photo>[];
    for (var photo in photos!) {
      // マスターに登録
      var photoRef = await addPhoto(userID, File(photo.image!.path));
      painRecordPhotos.add(photo.copyWith(ref: photoRef));
      // 痛み記録に登録
    }
    addPainRecordPhotos(userID, painRecordID, painRecordPhotos);
  }

  Future<void> addMedicine(
      Medicine medicine, String userID, String painRecordsID) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecordsID)
        .collection('medicines')
        .add({
      'medicineRef': medicine.medicineRef,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp()
    });
  }

  Future<void> addBodypart(
      BodyPart bodyPart, String userID, String painRecordsID) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecordsID)
        .collection('bodyParts')
        .add({
      'bodyPartRef': bodyPart.bodyPartRef,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp()
    });
  }

  Future<DocumentReference<Photo>?> addPhoto(String userID, File image) async {
    DocumentReference<Photo> ref;
    try {
      final result = await FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('photos')
          .child('${const Uuid().v4()}.${image.path.split('.')[1]}')
          .putFile(image);

      ref = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('photos')
          .withConverter<Photo>(
            fromFirestore: (snapshot, _) =>
                Photo.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
            toFirestore: (photo, _) => photo.toJson(),
          )
          .add(Photo(
              photoURL: await result.ref.getDownloadURL(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()));
      return ref;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  CollectionReference<PainRecord> _getPainRecordsRefByUserID(String userID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .withConverter<PainRecord>(
            fromFirestore: (snapshot, _) =>
                PainRecord.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
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
                PainRecord.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
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
            .orderBy('createdAt', descending: true)
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
            .orderBy('createdAt', descending: true)
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
    var registered = (await FirebaseFirestore.instance
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
            .orderBy('createdAt', descending: true)
            .get())
        .docs
        .map((e) => e.data())
        .toList();
    registered.add(Medicine(name: '未選択'));
    return registered;
  }

  @override
  Future<List<BodyPart>?> getBodyPartsByUserID(String userID) async {
    var registered = (await FirebaseFirestore.instance
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
    registered.add(BodyPart(name: '未選択'));
    return registered;
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

  Query<Photo> _getPhotoQueryByPainRecordID(
      String userID, String painRecordID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecordID)
        .collection('photos')
        .withConverter<Photo>(
          fromFirestore: (snapshot, _) {
            return Photo.fromJson(snapshot.data()!).copyWith(
                id: snapshot.data()!['photoRef'].id,
                painRecordPhotoId: snapshot.id,
                ref: _getPhotosRef(userID, snapshot.data()!['photoRef'].id),
                deleted: false);
          },
          toFirestore: (photo, _) => photo.toJson(),
        )
        .orderBy('createdAt', descending: true);
  }

  Future<List<Photo>?> _getPhotosRefByPainRecordID(
      String userID, String painRecordID) async {
    final painRecordPhotos =
        (await _getPhotoQueryByPainRecordID(userID, painRecordID).get())
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
        if (medicine.painRecordMedicineId != null && medicine.name == '未選択') {
          await _getPainRecordMedicineRef(userID, painRecord, medicine)
              .delete();
        } else if (medicine.painRecordMedicineId != null) {
          await _getPainRecordMedicineRef(userID, painRecord, medicine)
              .update({'medicineRef': medicine.medicineRef});
        } else if (medicine.painRecordMedicineId == null &&
            medicine.name != '未選択') {
          await addMedicine(medicine, userID, painRecord.getPainRecordID!);
        }
      }
    }

    if (bodyParts!.isNotEmpty) {
      for (var bodypart in bodyParts) {
        if (bodypart.painRecordBodyPartId != null && bodypart.name == '未選択') {
          await _getPainRecordBodyPartsRef(userID, painRecord, bodypart)
              .delete();
        } else if (bodypart.painRecordBodyPartId != null) {
          await _getPainRecordBodyPartsRef(userID, painRecord, bodypart)
              .update({'bodyPartRef': bodypart.bodyPartRef});
        } else if (bodypart.painRecordBodyPartId == null &&
            bodypart.name != '未選択') {
          await addBodypart(bodypart, userID, painRecord.getPainRecordID!);
        }
      }
    }
  }

  DocumentReference<Map<String, dynamic>> _getPainRecordMedicineRef(
      String userID, PainRecord painRecord, Medicine medicine) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecord.getPainRecordID)
        .collection('medicines')
        .doc(medicine.painRecordMedicineId);
  }

  DocumentReference<Map<String, dynamic>> _getPainRecordBodyPartsRef(
      String userID, PainRecord painRecord, BodyPart bodyPart) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('painRecords')
        .doc(painRecord.getPainRecordID)
        .collection('bodyParts')
        .doc(bodyPart.painRecordBodyPartId);
  }

  @override
  Future<void> deletePainRecordPhotos(
      String userID, String painRecordID, List<Photo> photos) async {
    try {
      for (var photo in photos) {
        if (photo.deleted!) {
          print(
              'deletePainRecordPhotos: painRecordPhotoID: ${photo.painRecordPhotoId}, photoID: ${photo.id}');
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
    } on Exception catch (e) {
      print(e);
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
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });
    }
  }

  @override
  Stream<List<Photo>?> getPhotosByPainRecordID(
      String userID, String painRecordID) async* {
    var photoStream =
        _getPhotoQueryByPainRecordID(userID, painRecordID).snapshots();

    var result = <Photo>[];
    await for (var querySnapshot in photoStream) {
      for (var documentSnapshot in querySnapshot.docs) {
        var photo = await _getPhoto(userID, documentSnapshot.data());
        result.add(photo);
      }
      result.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      yield result;
    }
  }
}
