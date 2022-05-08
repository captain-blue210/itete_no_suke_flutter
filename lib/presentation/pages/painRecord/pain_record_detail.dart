import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/painRecord/pain_record.dart';
import 'package:itete_no_suke/presentation/pages/setting/setting.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/body_parts_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/medicine_dropdown.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/memo_input.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_level_button_list.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_state.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_record_update_button.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/photo_buttons.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/photo_holder.dart';
import 'package:provider/provider.dart';
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
  void initState() {
    super.initState();
    context.read<PainRecordRequestParam>().init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('痛み記録'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            color: Colors.white,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Setting(),
              ),
            ),
          )
        ],
      ),
      body: context.watch<PainRecordState>().isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<PainRecord>(
              future: context
                  .read<PainRecordsService>()
                  .getPainRecord(widget.painRecordID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  context.read<PainRecordRequestParam>().id =
                      snapshot.data!.id!;

                  for (var medicine in snapshot.data!.medicines!) {
                    context.watch<PainRecordRequestParam>().medicines =
                        medicine;
                  }

                  for (var bodyPart in snapshot.data!.bodyParts!) {
                    context.read<PainRecordRequestParam>().bodyParts = bodyPart;
                  }
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                  registered: snapshot.data!.painLevel),
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
                                children:
                                    _createMedicineDropdown(snapshot.data!),
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
                                children:
                                    _createBodyPartsDropdown(snapshot.data!),
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
                              const PhotoHolder(),
                              const SizedBox(
                                height: 10,
                              ),
                              const PhotoButtons(),
                              const SizedBox(
                                height: 10,
                              ),
                              const PainRecordUpdateButton(),
                            ],
                          ),
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
    var registered = painRecord.medicines!
        .map((e) => MedicineDropdown(registered: e))
        .toList();
    while (registered.length < 5) {
      registered.add(const MedicineDropdown());
    }
    return registered;
  }

  List<Widget> _createBodyPartsDropdown(PainRecord painRecord) {
    var registered = painRecord.bodyParts!
        .map((e) => BodyPartsDropdown(registered: e))
        .toList();
    while (registered.length < 5) {
      registered.add(const BodyPartsDropdown());
    }
    return registered;
  }
}
