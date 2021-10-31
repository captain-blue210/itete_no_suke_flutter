import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/model/medicine/medicines.dart';
import 'package:itete_no_suke/view/widgets/medicine/medicine_card.dart';
import 'package:provider/src/provider.dart';

class MedicineCardList extends StatefulWidget {
  const MedicineCardList({Key? key}) : super(key: key);

  @override
  _MedicineCardListState createState() => _MedicineCardListState();
}

class _MedicineCardListState extends State<MedicineCardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Medicine>?>(
      // TODO need to use real userID
      future: context
          .read<Medicines>()
          .getMedicinesByUserID('elfT3lHp4FO0pxr9kh2r'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MedicineCard(name: snapshot.data![index].name);
            },
          );
        } else {
          return ListView();
        }
      },
    );
  }
}
