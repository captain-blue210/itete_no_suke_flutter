import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';

class PainRecord {
  late final DocumentReference painRecordRef;
  late final String userID;
  late final PainLevel painLevel;
  late final List<BodyPart>? _bodyParts;
  late final String memo;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  PainRecord(DocumentSnapshot doc) {
    painRecordRef = doc.reference;
    userID = doc['userID'];
    painLevel = PainLevel.values[doc['painLevel']];
    memo = doc['memo'];
    createdAt = doc['createdAt'].toDate();
    updatedAt = doc['updatedAt'].toDate();
  }

  set bodyParts(List<BodyPart>? bodyParts) {
    _bodyParts = bodyParts;
  }

  List<BodyPart>? get bodyParts => _bodyParts;

  Text get date =>
      Text('${createdAt.year}/${createdAt.month}/${createdAt.day}');

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
}
