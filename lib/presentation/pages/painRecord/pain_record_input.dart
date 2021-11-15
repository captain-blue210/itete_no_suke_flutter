import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/body_parts_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/medicine_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_level_button_list.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_save_button.dart';
import 'package:provider/provider.dart';

class PainRecordInput extends StatefulWidget {
  const PainRecordInput({Key? key}) : super(key: key);

  @override
  _PainRecordInputState createState() => _PainRecordInputState();
}

class _PainRecordInputState extends State<PainRecordInput> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PainRecordRequestParam>(
      create: (_) => PainRecordRequestParam(),
      child: Padding(
        padding: EdgeInsets.only(
            top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'いまどんなかんじ？',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PainLevelButtonList(),
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
                  const Text(
                    'メモ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        SizedBox(
                          height: 100,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'メモ',
                            ),
                          ),
                        ),
                      ]),
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    color: Colors.grey,
                    iconSize: 50,
                    onPressed: () {},
                  ),
                  const PainRecordSaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
