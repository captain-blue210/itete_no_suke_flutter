import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class BodyPartsDropdown extends StatefulWidget {
  const BodyPartsDropdown({Key? key}) : super(key: key);

  @override
  State<BodyPartsDropdown> createState() => _BodyPartsDropdownState();
}

class _BodyPartsDropdownState extends State<BodyPartsDropdown> {
  BodyPart? _selected;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BodyPart>?>(
      future: context
          .read<PainRecordsService>()
          .getBodyPartsByUserID('weMEInwFmywcbjTEhG2A'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<BodyPart>(
            hint: const Text('未選択'),
            isExpanded: true,
            onChanged: (value) {
              context.read<PainRecordRequestParam>().bodyParts = value!;
              setState(() => _selected = value);
            },
            items: initDropdownMenuItem(snapshot),
            value: _selected,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<DropdownMenuItem<BodyPart>> initDropdownMenuItem(
      AsyncSnapshot<List<BodyPart>?> snapshot) {
    return snapshot.data!.map((e) {
      return DropdownMenuItem<BodyPart>(
        value: e,
        child: Text(e.name),
      );
    }).toList();
  }
}
