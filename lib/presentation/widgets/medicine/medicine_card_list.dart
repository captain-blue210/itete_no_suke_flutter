import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/widgets/medicine/medicine_card.dart';
import 'package:provider/src/provider.dart';

class MedicineCardList extends StatefulWidget {
  const MedicineCardList({Key? key}) : super(key: key);

  @override
  _MedicineCardListState createState() => _MedicineCardListState();
}

class _MedicineCardListState extends State<MedicineCardList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Medicine>>(
      // TODO need to use real userID
      stream: context
          .read<MedicineService>()
          .getMedicinesByUserID('weMEInwFmywcbjTEhG2A'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return MedicineCard(name: snapshot.data!.docs[index].data().name);
            },
          );
        } else {
          return ListView();
        }
      },
    );
  }
}
