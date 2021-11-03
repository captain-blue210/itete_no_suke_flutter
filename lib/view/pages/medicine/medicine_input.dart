import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicine_service.dart';
import 'package:provider/src/provider.dart';

class MedicineInput extends StatefulWidget {
  const MedicineInput({Key? key}) : super(key: key);

  @override
  _MedicineInputState createState() => _MedicineInputState();
}

class _MedicineInputState extends State<MedicineInput> {
  final addMedicineController = TextEditingController();
  late FocusNode addMedicineFocusNode;

  @override
  void initState() {
    super.initState();
    addMedicineFocusNode = FocusNode();
  }

  @override
  void dispose() {
    addMedicineController.dispose();
    addMedicineFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicineService = context.read<MedicineService>();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                autofocus: true,
                onEditingComplete: () async {
                  if (addMedicineController.text.isNotEmpty) {
                    final medicine = Medicine(name: addMedicineController.text);
                    medicineService.addNewMedicine(medicine);
                  }
                  addMedicineController.clear();
                  addMedicineFocusNode.unfocus();
                  Navigator.pop(context);
                },
                controller: addMedicineController,
                focusNode: addMedicineFocusNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'お薬の名前',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
