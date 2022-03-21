import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/presentation/pages/painRecord/pain_record_detail.dart';

class PainRecordCard extends StatelessWidget {
  final PainRecord painRecord;

  const PainRecordCard({
    Key? key,
    required this.painRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: painRecord.getPainLevelIcon(),
        title: painRecord.date,
        subtitle: painRecord.getTop3BodyParts(),
        trailing: const Icon(Icons.keyboard_arrow_right),
        isThreeLine: true,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PainRecordDetail(painRecordID: painRecord.painRecordID!))),
      ),
    );
  }
}
