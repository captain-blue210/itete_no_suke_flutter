import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/widgets/body_parts_card_list.dart';

class BodyParts extends StatefulWidget {
  const BodyParts({Key? key}) : super(key: key);

  @override
  _BodyPartsState createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {
  BodyParts bodyParts = BodyParts();
  @override
  Widget build(BuildContext context) {
    return BodyPartsCardList();
  }
}
