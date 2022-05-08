import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/widgets/medicine/medicine_save_button.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class MedicineDetail extends StatefulWidget {
  final String medicineID;
  const MedicineDetail({Key? key, required this.medicineID}) : super(key: key);

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  final _updateNameController = TextEditingController();
  final _updateMemoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お薬'),
      ),
      body: FutureBuilder<Medicine>(
        future: context.read<MedicineService>().getMedicine(widget.medicineID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _updateNameController.text = snapshot.data!.name;
            _updateMemoController.text = snapshot.data!.memo!;
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'お薬名',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: _updateNameController,
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
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          constraints: BoxConstraints.expand(height: 200),
                          border: OutlineInputBorder(),
                        ),
                        controller: _updateMemoController,
                      ),
                      MedicineSaveButton(
                        ref: snapshot.data!.medicineRef,
                        name: _updateNameController,
                        memo: _updateMemoController,
                      ),
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
}
