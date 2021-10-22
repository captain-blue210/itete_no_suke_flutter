import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/pages/pain_record.dart';

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
    Icon(
      Icons.medical_services,
      size: 150,
    ),
    pain_record_list(),
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
            builder: (context) => PainRecordPage(),
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

class pain_record_list extends StatelessWidget {
  const pain_record_list({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.tag_faces),
            title: Text('2021/10/22'),
            subtitle: Text('1. dummy1\n2. dummy2\n3. dummy3'),
            trailing: Icon(Icons.keyboard_arrow_right),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.tag_faces),
            title: Text('2021/10/23'),
            subtitle: Text('1. dummy1\n2. dummy2\n3. dummy3'),
            trailing: Icon(Icons.keyboard_arrow_right),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.tag_faces),
            title: Text('2021/10/23'),
            subtitle: Text('1. dummy1\n2. dummy2\n3. dummy3'),
            trailing: Icon(Icons.keyboard_arrow_right),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.tag_faces),
            title: Text('2021/10/23'),
            subtitle: Text('1. dummy1\n2. dummy2\n3. dummy3'),
            trailing: Icon(Icons.keyboard_arrow_right),
            isThreeLine: true,
          ),
        ),
        TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const PainRecordPage(),
                )),
            child: const Text('体調を記録する'))
      ],
    );
  }
}
