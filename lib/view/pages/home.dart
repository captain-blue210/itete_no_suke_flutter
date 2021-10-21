import 'package:flutter/material.dart';
import 'package:itetenosukte_flutter/view/pages/pain_record.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('いててのすけ'),
      ),
      body: Center(
        child: ListView(
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
        ),
      ),
    );
  }
}
