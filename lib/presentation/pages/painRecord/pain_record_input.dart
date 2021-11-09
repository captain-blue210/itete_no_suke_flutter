import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
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
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
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
                FutureBuilder<List<Medicine>?>(
                  future: context
                      .read<PainRecordsService>()
                      .getMedicinesByUserID('weMEInwFmywcbjTEhG2A'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MedicineDropdown(values: snapshot.data!),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          MedicineDropdown(values: []),
                        ],
                      );
                    }
                  },
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
                      TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'メモ',
                          )),
                    ]),
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
    );
  }
}
