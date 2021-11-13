import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class MedicineDropdown extends StatefulWidget {
  final List<Medicine>? values;
  const MedicineDropdown({Key? key, required this.values}) : super(key: key);

  @override
  State<MedicineDropdown> createState() => _MedicineDropdownState();
}

class _MedicineDropdownState extends State<MedicineDropdown> {
  late Medicine _selected;
  @override
  void initState() {
    _selected = widget.values![0];
    context.read<PainRecordRequestParam>().medicines = widget.values![0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Medicine>(
      isExpanded: true,
      onChanged: (value) {
        context.read<PainRecordRequestParam>().medicines = value!;
        setState(() => _selected = value);
      },
      items: widget.values!
          .map(
            (e) => DropdownMenuItem<Medicine>(
              value: e,
              child: Text(e.name),
            ),
          )
          .toList(),
      value: _selected,
    );
  }
}
