import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_state.dart';
import 'package:provider/src/provider.dart';

class PainRecordUpdateButton extends StatefulWidget {
  const PainRecordUpdateButton({
    Key? key,
  }) : super(key: key);

  @override
  State<PainRecordUpdateButton> createState() => _PainRecordUpdateButtonState();
}

class _PainRecordUpdateButtonState extends State<PainRecordUpdateButton> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
            showProgressDialog(context);

            await context
                .read<PainRecordsService>()
                .updatePainRecord(context.read<PainRecordRequestParam>());

            context.read<PainRecordRequestParam>().deleteMedicines(
                (medicine) => medicine.painRecordMedicineId == null);

            context.read<PainRecordRequestParam>().deleteBodyParts(
                (bodypart) => bodypart.painRecordBodyPartId == null);

            context
                .read<PainRecordRequestParam>()
                .deletePhotos((photo) => photo.painRecordPhotoId == null);

            await Future.delayed(const Duration(seconds: 1));
            Navigator.pop(context);
            context.read<PainRecordState>().toggleLoading();

            showDialog<String>(
              context: context,
              builder: (context) => showCompleteDialog(context),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }

  AlertDialog showCompleteDialog(BuildContext context) {
    return AlertDialog(
      content: const Text('痛み記録を更新しました。'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
            context.read<PainRecordState>().toggleLoading();
          },
          child: const Text('OK'),
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
