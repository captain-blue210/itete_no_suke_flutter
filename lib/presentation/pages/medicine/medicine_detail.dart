import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:provider/src/provider.dart';

class MedicineDetail extends StatefulWidget {
  final String medicineID;
  const MedicineDetail({Key? key, required this.medicineID}) : super(key: key);

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お薬'),
      ),
      body: FutureBuilder<Medicine>(
        future: context.read<MedicineService>().getUser(widget.medicineID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data!.name));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
