import 'package:flutter/material.dart';

class BodyPartsCard extends StatelessWidget {
  final String name;

  const BodyPartsCard({Key? key, required this.name}) : super(key: key);

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
