import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyPartsList extends StatefulWidget {
  const BodyPartsList({Key? key}) : super(key: key);

  @override
  _BodyPartsListState createState() => _BodyPartsListState();
}

class _BodyPartsListState extends State<BodyPartsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text('痛い部位1'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('痛い部位2'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('痛い部位3'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('痛い部位4'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('痛い部位5'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ],
    );
  }
}
