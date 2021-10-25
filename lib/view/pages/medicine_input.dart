import 'package:flutter/material.dart';

class MedicineInput extends StatefulWidget {
  const MedicineInput({Key? key}) : super(key: key);

  @override
  _MedicineInputState createState() => _MedicineInputState();
}

class _MedicineInputState extends State<MedicineInput> {
  @override
  Widget build(BuildContext context) {
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
                onEditingComplete: () {},
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
