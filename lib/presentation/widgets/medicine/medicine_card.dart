import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final String name;

  const MedicineCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
