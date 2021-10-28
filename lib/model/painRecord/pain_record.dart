import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/model/bodyParts/body_part.dart';
import 'package:itetenosukte_flutter/model/painRecord/pain_level.dart';

class PainRecord {
  final String _date;
  final List<BodyPart> _bodyParts;
  final PainLevel _painLevel;

  PainRecord(this._date, this._bodyParts, this._painLevel);

  Text get date => Text(_date);
  List<BodyPart> get bodyParts => _bodyParts;
  PainLevel get painLevel => _painLevel;

  Wrap getTop3BodyParts() {
    return Wrap(
      children: List.generate(
          _bodyParts.length, (index) => Text(_bodyParts[index].name)),
    );
  }

  Icon? getPainLevelIcon() {
    switch (_painLevel) {
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
