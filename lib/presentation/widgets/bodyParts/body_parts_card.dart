import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/pages/bodyParts/body_parts_detail.dart';

class BodyPartsCard extends StatelessWidget {
  final String? name;
  final String? bodyPartsID;

  const BodyPartsCard({Key? key, required this.name, required this.bodyPartsID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name!),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BodyPartsDetail(
              bodyPartsID: bodyPartsID!,
            ),
          ),
        ),
      ),
    );
  }
}
