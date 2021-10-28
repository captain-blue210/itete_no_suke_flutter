import 'package:flutter/material.dart';
import 'package:itete_no_suke/view/pages/bodyParts/body_parts_list.dart';
import 'package:itete_no_suke/view/pages/medicine/medicine_list.dart';
import 'package:itete_no_suke/view/pages/painRecord/pain_record_list.dart';
import 'package:itete_no_suke/view/pages/photo/photo_list.dart';
import 'package:itete_no_suke/view/widgets/home/add_button.dart';
import 'package:itete_no_suke/view/widgets/home/add_button_index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AddButton addButton = AddButton();
  static const List<Widget> _pages = <Widget>[
    PhotoList(),
    BodyPartsList(),
    MedicineList(),
    PainRecordList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('いててのすけ'),
      ),
      body: Center(
        child: _pages.elementAt(addButton.getCurrentIndex()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return addButton.getAddButton();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: '写真',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_accessibility),
            label: '部位',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'お薬',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: addButton.getCurrentIndex(),
        onTap: (index) {
          setState(() {
            addButton.index = AddButtonIndex.values[index];
          });
        },
      ),
    );
  }
}
