import 'package:flutter/cupertino.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/model/painRecord/pain_records.dart';
import 'package:itete_no_suke/view/widgets/painRecord/pain_record_card.dart';
import 'package:provider/src/provider.dart';

class PainRecordCardList extends StatefulWidget {
  const PainRecordCardList({Key? key}) : super(key: key);

  @override
  _PainRecordCardListState createState() => _PainRecordCardListState();
}

class _PainRecordCardListState extends State<PainRecordCardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PainRecord>?>(
      // TODO need to use real userID
      future: context
          .read<PainRecords>()
          .getPainRecordsByUserID('elfT3lHp4FO0pxr9kh2r'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                PainRecordCard(painRecord: snapshot.data![index]),
          );
        } else {
          return ListView();
        }
      },
    );
  }
}
