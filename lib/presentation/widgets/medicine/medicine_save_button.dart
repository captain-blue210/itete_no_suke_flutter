import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:provider/src/provider.dart';

class MedicineSaveButton extends StatefulWidget {
  final DocumentReference<Medicine>? ref;
  final TextEditingController name;
  final TextEditingController memo;
  const MedicineSaveButton(
      {Key? key, required this.ref, required this.name, required this.memo})
      : super(key: key);

  @override
  State<MedicineSaveButton> createState() => _MedicineSaveButtonState();
}

class _MedicineSaveButtonState extends State<MedicineSaveButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 50,
          child: TextButton(
            child: isLoading
                ? const SizedBox(
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text('保存',
                    style: TextStyle(
                      color: Colors.white,
                    )),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              Medicine medicine = Medicine(
                name: widget.name.text,
                memo: widget.memo.text,
              ).copyWith(id: widget.ref!.id, ref: widget.ref);

              context.read<MedicineService>().updateMedicine(medicine);
              await Future.delayed(Duration(seconds: 2));

              setState(() {
                isLoading = false;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
          ),
        )
      ],
    );
  }
}
