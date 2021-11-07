import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/presentation/widgets/bodyParts/body_parts_card.dart';
import 'package:provider/src/provider.dart';

class BodyPartsCardList extends StatefulWidget {
  const BodyPartsCardList({Key? key}) : super(key: key);

  @override
  _BodyPartsCardListState createState() => _BodyPartsCardListState();
}

class _BodyPartsCardListState extends State<BodyPartsCardList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<BodyPart>>(
      stream: context.read<BodyPartsService>().getBodyPartsByUserID(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              return BodyPartsCard(
                  name: snapshot.data!.docs[index].data().name);
            },
          );
        } else {
          return ListView();
        }
      },
    );
  }
}
