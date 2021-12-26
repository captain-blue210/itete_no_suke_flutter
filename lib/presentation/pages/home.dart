import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/pages/bodyParts/body_parts_list.dart';
import 'package:itete_no_suke/presentation/pages/medicine/medicine_list.dart';
import 'package:itete_no_suke/presentation/pages/painRecord/pain_record_list.dart';
import 'package:itete_no_suke/presentation/pages/photo/photo_list.dart';
import 'package:itete_no_suke/presentation/widgets/home/add_button.dart';
import 'package:itete_no_suke/presentation/widgets/home/add_button_index.dart';

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
        actions: createSelectPhotoButton(context),
      ),
      body: Center(
        child: _pages.elementAt(addButton.getCurrentIndex()),
      ),
      floatingActionButton: createFloatingActionButton(context),
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

  void showInputForm(BuildContext context) {
    if (addButton.getCurrentIndex() == AddButtonIndex.photo.index) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return addButton.getAddButton();
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return addButton.getAddButton();
        },
      );
    }
  }

  List<Widget>? createSelectPhotoButton(BuildContext context) {
    if (isPhotoPage()) {
      return <Widget>[
        TextButton(
          child: const Text(
            '選択',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {},
        )
      ];
    }
  }

  bool isPhotoPage() {
    return addButton.getCurrentIndex() == AddButtonIndex.photo.index;
  }

  Widget createFloatingActionButton(BuildContext context) {
    if (isPhotoPage()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          getDeleteFloatingActionButton(context),
          const SizedBox(
            width: 10,
          ),
          getAddFloatingActionButton(context),
        ],
      );
    } else {
      return getAddFloatingActionButton(context);
    }
  }

  Widget getAddFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showInputForm(context);
      },
      child: const Icon(Icons.add),
    );
  }

  Widget getDeleteFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.delete),
      backgroundColor: Colors.red,
    );
  }
}
