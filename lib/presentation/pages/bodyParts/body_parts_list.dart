import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/presentation/widgets/bodyParts/body_parts_card.dart';
import 'package:provider/src/provider.dart';

class BodyPartsList extends StatefulWidget {
  const BodyPartsList({Key? key}) : super(key: key);

  @override
  _BodyPartsListState createState() => _BodyPartsListState();
}

class _BodyPartsListState extends State<BodyPartsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<BodyPart>>(
      stream: context.read<BodyPartsService>().getBodyPartsByUserID(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
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
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  context
                      .read<BodyPartsService>()
                      .deleteBodyPart(snapshot.data!.docs[index].id);
                },
                child: BodyPartsCard(
                    name: snapshot.data!.docs[index].data().name!,
                    bodyPartsID: snapshot.data!.docs[index].id),
              );
            },
          );
        } else {
          return ListView();
        }
      },
    );
  }
}
