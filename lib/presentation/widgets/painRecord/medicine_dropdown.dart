import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class MedicineDropdown extends StatefulWidget {
  final Medicine? registered;
  const MedicineDropdown({Key? key, this.registered}) : super(key: key);

  @override
  State<MedicineDropdown> createState() => _MedicineDropdownState();
}

class _MedicineDropdownState extends State<MedicineDropdown> {
  Medicine? _selected;

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
    return FutureBuilder<List<Medicine>?>(
      future: context.read<PainRecordsService>().getMedicinesByUserID(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<Medicine>(
            value: snapshot.data!.firstWhere((e) => e.id == _selected!.id),
            items: initDropdownMenuItem(snapshot),
            hint: const Text('未選択'),
            isExpanded: true,
            onChanged: (newMedicine) async {
              context.read<PainRecordRequestParam>().medicines = newMedicine!
                  .copyWith(
                      painRecordMedicineId:
                          widget.registered!.painRecordMedicineId);
              setState(() => _selected = newMedicine);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<DropdownMenuItem<Medicine>> initDropdownMenuItem(
      AsyncSnapshot<List<Medicine>?> snapshot) {
    return snapshot.data!.map((e) {
      return DropdownMenuItem<Medicine>(
        value: e,
        child: Text(e.name!),
      );
    }).toList();
  }
}
