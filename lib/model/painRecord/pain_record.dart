import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

class PainRecord {
  final String? painRecordID;
  final PainLevel painLevel;
  late final List<Medicine>? _medicines;
  late final List<BodyPart>? _bodyParts;
  late final List<Photo>? _photos;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PainRecord({
    this.painRecordID,
    required this.painLevel,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  String? get getPainRecordID => painRecordID;

  Text get date =>
      Text('${createdAt!.year}/${createdAt!.month}/${createdAt!.day}');

  List<BodyPart>? get bodyParts => _bodyParts;
  PainRecord setBodyParts(List<BodyPart>? bodyParts) {
    _bodyParts = bodyParts;
    return this;
  }

  Column getTop3BodyParts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        _bodyParts!.length,
        (index) => Text(_bodyParts![index].name),
      ),
    );
  }

  Icon? getPainLevelIcon() {
    switch (painLevel) {
      case PainLevel.noPain:
        return const Icon(Icons.sentiment_very_satisfied);
      case PainLevel.moderate:
        return const Icon(Icons.sentiment_satisfied);
      case PainLevel.verySevere:
        return const Icon(Icons.sentiment_dissatisfied);
      case PainLevel.worst:
        return const Icon(Icons.sentiment_very_dissatisfied);
    }
  }

  List<Medicine>? get medicines => _medicines;
  PainRecord setMedicines(List<Medicine>? medicines) {
    _medicines = medicines;
    return this;
  }

  List<Photo>? get photos => _photos;
  PainRecord setPhotos(List<Photo>? photos) {
    _photos = photos;
    return this;
  }

  PainRecord.fromJson(String? id, Map<String, dynamic> json)
      : this(
          painRecordID: id,
          painLevel: PainLevel.values[(json['painLevel'] as int)],
          memo: json['memo'] as String? ?? '',
          createdAt: (json['createdAt'] as Timestamp).toDate(),
          updatedAt: (json['updatedAt'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() {
    return {
      'painLevel': painLevel.index,
      'memo': memo,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp()
    };
  }
}
