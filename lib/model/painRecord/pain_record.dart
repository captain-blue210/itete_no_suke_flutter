import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecord {
  final String? painRecordsID;
  final PainLevel painLevel;
  late final List<Medicine>? _medicines;
  late final List<BodyPart>? _bodyParts;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PainRecord({
    this.painRecordsID,
    required this.painLevel,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  Text get date =>
      Text('${createdAt!.year}/${createdAt!.month}/${createdAt!.day}');

  List<BodyPart>? get bodyParts => _bodyParts;
  List<Medicine>? get medicines => _medicines;

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
        break;
      case PainLevel.moderate:
        return const Icon(Icons.sentiment_satisfied);
        break;
      case PainLevel.verySevere:
        return const Icon(Icons.sentiment_dissatisfied);
        break;
      case PainLevel.worst:
        return const Icon(Icons.sentiment_very_dissatisfied);
        break;
    }
  }

  PainRecord setMedicines(List<Medicine>? medicines) {
    _medicines = medicines;
    return this;
  }

  set bodyParts(List<BodyPart>? bodyParts) {
    _bodyParts = bodyParts;
  }

  PainRecord.fromJson(Map<String, Object?> json)
      : this(
          painRecordsID: json['painRecordsID'] as String? ?? '',
          painLevel: json['painLevel'] as PainLevel,
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
