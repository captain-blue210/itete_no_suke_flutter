import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/pages/photo/new_painrecord_photo_input.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/body_parts_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/medicine_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/memo_input.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/new_painrecord_photo_holder.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_level_button_list.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_save_button.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class PainRecordInput extends StatefulWidget {
  const PainRecordInput({Key? key}) : super(key: key);

  @override
  _PainRecordInputState createState() => _PainRecordInputState();
}

class _PainRecordInputState extends State<PainRecordInput> {
  @override
  void initState() {
    super.initState();
    context.read<PainRecordRequestParam>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
              const Text(
                'いまどんなかんじ？',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PainLevelButtonList(
                  registered: context.select(
                      (PainRecordRequestParam param) => param.painLevel)),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'おくすりのんだ？',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  MedicineDropdown(),
                  MedicineDropdown(),
                  MedicineDropdown(),
                  MedicineDropdown(),
                  MedicineDropdown(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '痛いところは？',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  BodyPartsDropdown(),
                  BodyPartsDropdown(),
                  BodyPartsDropdown(),
                  BodyPartsDropdown(),
                  BodyPartsDropdown(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'メモ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const MemoInput(),
              const SizedBox(
                height: 20,
              ),
              const NewPainReocrdPhotoHolder(),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('写真を追加する'),
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.blue),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return const NewPainRecordPhotoInput();
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const PainRecordSaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
