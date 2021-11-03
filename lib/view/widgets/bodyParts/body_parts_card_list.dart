import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts.dart';
import 'package:itete_no_suke/view/widgets/bodyParts/body_parts_card.dart';
import 'package:provider/src/provider.dart';

class BodyPartsCardList extends StatefulWidget {
  const BodyPartsCardList({Key? key}) : super(key: key);

  @override
  _BodyPartsCardListState createState() => _BodyPartsCardListState();
}

class _BodyPartsCardListState extends State<BodyPartsCardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BodyPart>?>(
      // TODO need to use real userID
      future: context
          .read<BodyParts>()
          .getBodyPartsByUserID('p0HnEbeA3SVggtl9Ya8k'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return BodyPartsCard(name: snapshot.data![index].name);
            },
          );
        } else {
          print(snapshot.error);
          return ListView();
        }
      },
    );
  }
}
