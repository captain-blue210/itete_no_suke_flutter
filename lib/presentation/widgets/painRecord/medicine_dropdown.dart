import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class MedicineDropdown extends StatefulWidget {
  const MedicineDropdown({Key? key}) : super(key: key);

  @override
  State<MedicineDropdown> createState() => _MedicineDropdownState();
}

class _MedicineDropdownState extends State<MedicineDropdown> {
  late Future<List<Medicine>?> futureMedicines =
      context.read<PainRecordsService>().getMedicinesByUserID();
  Medicine? _selected;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Medicine>?>(
      future: futureMedicines,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<Medicine>(
            hint: const Text('未選択'),
            isExpanded: true,
            onChanged: (value) {
              context.read<PainRecordRequestParam>().medicines = value!;
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

  List<DropdownMenuItem<Medicine>> initDropdownMenuItem(
      AsyncSnapshot<List<Medicine>?> snapshot) {
    return snapshot.data!.map((e) {
      return DropdownMenuItem<Medicine>(
        value: e,
        child: Text(e.name),
      );
    }).toList();
  }
}
