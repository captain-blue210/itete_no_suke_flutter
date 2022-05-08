import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/presentation/widgets/auth/auth_state.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_card.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class PainRecordList extends StatelessWidget {
  const PainRecordList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PainRecord>>(
      stream: context.read<PainRecordsService>().getPainRecordsByUserID(),
      initialData: const [],
      builder: (context, snapshot) {
        if (!context.watch<AuthState>().isLogin ||
            (context.watch<AuthState>().isLogin && snapshot.data!.isEmpty)) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.edit_note,
                      color: Colors.grey,
                      size: 100,
                    ),
                  ),
                  Text(
                    'まだ記録がないようです。',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    '右下のボタンから記録を追加してみましょう🐯',
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          );
        }
        return SafeArea(
          child: ListView.builder(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) =>
                PainRecordCard(painRecord: snapshot.requireData[index]),
          ),
        );
      },
    );
  }
}
