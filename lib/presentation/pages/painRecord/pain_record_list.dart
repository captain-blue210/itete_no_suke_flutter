import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_card.dart';
import 'package:provider/src/provider.dart';

class PainRecordList extends StatelessWidget {
  const PainRecordList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PainRecord>?>(
      stream: context.read<PainRecordsService>().getPainRecordsByUserID(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: snapshot.requireData!.length,
          itemBuilder: (context, index) =>
              PainRecordCard(painRecord: snapshot.requireData![index]),
        );
      },
    );
  }
}
