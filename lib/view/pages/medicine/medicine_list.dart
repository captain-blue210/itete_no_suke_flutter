import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/widgets/medicine/medicine_card_list.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return MedicineCardList();
  }
}
