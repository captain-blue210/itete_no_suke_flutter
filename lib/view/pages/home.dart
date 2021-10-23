import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/pages/medicine_list.dart';
import 'package:itetenosukte_flutter/view/pages/medicine_registration.dart';
import 'package:itetenosukte_flutter/view/pages/pain_record.dart';
import 'package:itetenosukte_flutter/view/pages/pain_record_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static int _selectedIndex = 3;
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.photo_album,
      size: 150,
    ),
    Icon(
      Icons.settings_accessibility,
      size: 150,
    ),
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
        child: _pages.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              if (_selectedIndex == 2) {
                return MedicineRegistration();
              }
              return PainRecord();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'アルバム',
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
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
