import 'package:flutter/material.dart';

class BodyPartsInput extends StatefulWidget {
  const BodyPartsInput({Key? key}) : super(key: key);

  @override
  _BodyPartsInputState createState() => _BodyPartsInputState();
}

class _BodyPartsInputState extends State<BodyPartsInput> {
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '痛む部位の名前'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
