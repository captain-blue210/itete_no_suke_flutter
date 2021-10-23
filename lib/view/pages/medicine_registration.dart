import 'package:flutter/material.dart';

class MedicineRegistration extends StatefulWidget {
  const MedicineRegistration({Key? key}) : super(key: key);

  @override
  _MedicineRegistrationState createState() => _MedicineRegistrationState();
}

class _MedicineRegistrationState extends State<MedicineRegistration> {
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
