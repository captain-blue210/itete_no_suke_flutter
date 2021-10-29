import 'dart:collection';

import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/painRecord/PainRecordRepositoryInterface.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';

class PainRecordRepositoryMock implements PainRecordRepositoryInterface {
  static final List<Map<String, dynamic>> _painRecordList = [
    {
      'date': '2021/10/22',
      'bodyParts': [
        '部位1',
        '部位2',
        '部位3',
      ],
      'painLevel': 0
    },
    {
      'date': '2021/10/23',
      'bodyParts': [
        '部位2',
        '部位1',
        '部位3',
      ],
      'painLevel': 1
    },
    {
      'date': '2021/10/24',
      'bodyParts': [
        '部位2',
        '部位3',
        '部位1',
      ],
      'painLevel': 2
    },
    {
      'date': '2021/10/25',
      'bodyParts': [
        '部位3',
        '部位2',
        '部位1',
      ],
      'painLevel': 3
    }
  ];

  @override
  Future<List<PainRecord>> findAll() {
    return Future.value(UnmodifiableListView(_painRecordList.map((painRecord) =>
        PainRecord(
            painRecord['date'].toString(),
            List.generate(painRecord['bodyParts'].length,
                (index) => BodyPart(name: painRecord['bodyParts'][index])),
            PainLevel.values[painRecord['painLevel']]))));
  }
}
