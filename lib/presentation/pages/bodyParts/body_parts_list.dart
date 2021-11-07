import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/widgets/bodyParts/body_parts_card_list.dart';

class BodyPartsList extends StatefulWidget {
  const BodyPartsList({Key? key}) : super(key: key);

  @override
  _BodyPartsListState createState() => _BodyPartsListState();
}

class _BodyPartsListState extends State<BodyPartsList> {
  @override
  Widget build(BuildContext context) {
    return BodyPartsCardList();
  }
}
