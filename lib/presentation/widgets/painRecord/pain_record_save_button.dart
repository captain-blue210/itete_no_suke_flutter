import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class PainRecordSaveButton extends StatelessWidget {
  const PainRecordSaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          child: const Text('保存',
              style: TextStyle(
                color: Colors.white,
              )),
          onPressed: () {
            context
                .read<PainRecordsService>()
                .addPainRecord(context.read<PainRecordRequestParam>());
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }
}
