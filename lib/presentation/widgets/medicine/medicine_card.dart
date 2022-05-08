import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/pages/medicine/medicine_detail.dart';

class MedicineCard extends StatelessWidget {
  final String? name;
  final String? medicineID;

  const MedicineCard({Key? key, required this.name, required this.medicineID})
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
              builder: (context) => MedicineDetail(
                medicineID: medicineID!,
              ),
            )),
      ),
    );
  }
}
