import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/src/provider.dart';

class BodyPartsDropdown extends StatefulWidget {
  final BodyPart? registered;
  const BodyPartsDropdown({Key? key, this.registered}) : super(key: key);

  @override
  State<BodyPartsDropdown> createState() => _BodyPartsDropdownState();
}

class _BodyPartsDropdownState extends State<BodyPartsDropdown> {
  BodyPart? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.registered;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BodyPart>?>(
      future: context.read<PainRecordsService>().getBodyPartsByUserID(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var isNotSelected =
              snapshot.data!.every((e) => e.id != _selected?.id);
          return DropdownButton<BodyPart>(
            value: isNotSelected
                ? null
                : snapshot.data!.firstWhere((e) => e.id == _selected?.id),
            items: initDropdownMenuItem(snapshot),
            hint: const Text('未選択'),
            isExpanded: true,
            onChanged: (newBodyPart) async {
              context.read<PainRecordRequestParam>().bodyParts = newBodyPart!
                  .copyWith(
                      painRecordBodyPartId: _selected?.painRecordBodyPartId);
              setState(() => _selected = newBodyPart.copyWith(
                  painRecordBodyPartId: _selected?.painRecordBodyPartId));
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<DropdownMenuItem<BodyPart>> initDropdownMenuItem(
      AsyncSnapshot<List<BodyPart>?> snapshot) {
    return snapshot.data!.map((e) {
      return DropdownMenuItem<BodyPart>(
        value: e,
        child: Text(e.name!),
      );
    }).toList();
  }
}
