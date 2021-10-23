import 'package:flutter/material.dart';

class BodyPartsRegistration extends StatefulWidget {
  const BodyPartsRegistration({Key? key}) : super(key: key);

  @override
  _BodyPartsRegistrationState createState() => _BodyPartsRegistrationState();
}

class _BodyPartsRegistrationState extends State<BodyPartsRegistration> {
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
                    border: OutlineInputBorder(), labelText: '痛む部位の名前'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
