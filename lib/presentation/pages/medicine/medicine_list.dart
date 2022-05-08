import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/medicine/medicine_service.dart';
import 'package:itete_no_suke/model/medicine/medicine.dart';
import 'package:itete_no_suke/presentation/widgets/auth/auth_state.dart';
import 'package:itete_no_suke/presentation/widgets/medicine/medicine_card.dart';
import 'package:provider/src/provider.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Medicine>>(
      stream: context.read<MedicineService>().getMedicinesByUserID(),
      builder: (context, snapshot) {
        if (!context.watch<AuthState>().isLogin ||
            (context.watch<AuthState>().isLogin &&
                snapshot.data!.docs.isEmpty)) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.grey,
                      size: 100,
                    ),
                  ),
                  Text(
                    'まだお薬の登録ががないようです。',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    '右下のボタンからお薬を追加してみましょう🐯',
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          );
        }
        return SafeArea(
          child: ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white)),
                ),
                onDismissed: (direction) {
                  context
                      .read<MedicineService>()
                      .deleteMedicine(snapshot.data!.docs[index].id);
                },
                child: MedicineCard(
                  name: snapshot.data!.docs[index].data().name!,
                  medicineID: snapshot.data!.docs[index].id,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
