import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class PainRecordUpdateButton extends StatelessWidget {
  const PainRecordUpdateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          child: const Text('更新',
              style: TextStyle(
                color: Colors.white,
              )),
          onPressed: () async {
            await context
                .read<PainRecordsService>()
                .updatePainRecord(context.read<PainRecordRequestParam>());

            showProgressDialog(context);
            await Future.delayed(const Duration(seconds: 1));
            Navigator.pop(context);

            showAboutDialog(context: context);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }

  void showProgressDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
