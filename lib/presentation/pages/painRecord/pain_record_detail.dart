import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/presentation/pages/photo/photo_input.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/body_parts_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/medicine_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/memo_input.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_level_button_list.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_update_button.dart';
import 'package:provider/src/provider.dart';

class PainRecordDetail extends StatefulWidget {
  final String painRecordID;
  const PainRecordDetail({Key? key, required this.painRecordID})
      : super(key: key);

  @override
  State<PainRecordDetail> createState() => _PainRecordDetailState();
}

class _PainRecordDetailState extends State<PainRecordDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('痛み記録'),
      ),
      body: FutureBuilder<PainRecord>(
        future: context
            .read<PainRecordsService>()
            .getPainRecord(widget.painRecordID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            context.read<PainRecordRequestParam>().id =
                snapshot.data!.painRecordID!;

            for (var bodyPart in snapshot.data!.bodyParts!) {
              context.read<PainRecordRequestParam>().bodyParts = bodyPart;
            }

            for (var medicine in snapshot.data!.medicines!) {
              context.read<PainRecordRequestParam>().medicines = medicine;
            }

            return Padding(
              padding: EdgeInsets.only(
                  top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'いまどんなかんじ？',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PainLevelButtonList(
                          selected: context.select(
                              (PainRecordRequestParam param) =>
                                  param.painLevel)),
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
                        children: _createMedicineDropdown(snapshot.data!),
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
                        children: _createBodyPartsDropdown(snapshot.data!),
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
                      MemoInput(registered: snapshot.data!.memo),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.add_a_photo),
                            label: const Text('写真を追加する'),
                            style: TextButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return PhotoInput(fromPainRecord: true);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      _getPhotoPageView(snapshot.data!),
                      const SizedBox(
                        height: 20,
                      ),
                      const PainRecordUpdateButton(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _createMedicineDropdown(PainRecord painRecord) {
    return painRecord.medicines!
        .map((e) => MedicineDropdown(registered: e))
        .toList();
  }

  List<Widget> _createBodyPartsDropdown(PainRecord painRecord) {
    return painRecord.bodyParts!
        .map((e) => BodyPartsDropdown(registered: e))
        .toList();
  }

  Widget _getPhotoPageView(PainRecord painRecord) {
    if (painRecord.photos!.isNotEmpty) {
      return SizedBox(
        height: 240,
        child: PageView.builder(
          key: UniqueKey(),
          controller: PageController(viewportFraction: 0.8),
          itemCount: painRecord.photos!.length,
          itemBuilder: (context, index) {
            return Builder(
              builder: (context) =>
                  _getImage(false, painRecord.photos![index].photoURL),
            );
          },
        ),
      );
    }
    return Container();
  }

  Image _getImage(bool doRegist, String photoURL) {
    if (doRegist) {
      return Image.file(File(photoURL));
    } else {
      return Image.network(photoURL);
    }
  }
}
