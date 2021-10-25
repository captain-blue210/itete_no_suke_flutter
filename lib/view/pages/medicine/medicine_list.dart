import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/pages/painRecord/pain_record_input.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text('お薬1'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => showBottomSheet(
              context: context,
              builder: (context) => PainRecordInput(),
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('お薬2'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('お薬3'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('お薬4'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('お薬5'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ],
    );
  }
}
