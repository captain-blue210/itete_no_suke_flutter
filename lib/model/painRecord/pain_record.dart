import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecord {
  final PainLevel painLevel;
  late final List<BodyPart>? _bodyParts;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PainRecord({
    required this.painLevel,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  Text get date =>
      Text('${createdAt!.year}/${createdAt!.month}/${createdAt!.day}');

  List<BodyPart>? get bodyParts => _bodyParts;

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

  PainRecord setBodyParts(List<BodyPart>? bodyParts) {
    _bodyParts = bodyParts;
    return this;
  }

  PainRecord.fromJson(Map<String, dynamic> json)
      : this(
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
