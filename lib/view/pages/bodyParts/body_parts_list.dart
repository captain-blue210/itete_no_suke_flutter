import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/widgets/bodyParts/body_parts_card_list.dart';

class BodyPartsList extends StatefulWidget {
  const BodyPartsList({Key? key}) : super(key: key);

  @override
  _BodyPartsListState createState() => _BodyPartsListState();
}

class _BodyPartsListState extends State<BodyPartsList> {
  BodyPartsList bodyParts = BodyPartsList();
  @override
  Widget build(BuildContext context) {
    return BodyPartsCardList();
  }
}
