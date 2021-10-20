import 'package:flutter/material.dart';

class PainRecordPage extends StatefulWidget {
  const PainRecordPage({Key? key}) : super(key: key);

  @override
  _PainRecordPageState createState() => _PainRecordPageState();
}

class _PainRecordPageState extends State<PainRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('体調記録'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'いまどんなかんじ？',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.tag_faces),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.tag_faces),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.tag_faces),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.tag_faces),
                  onPressed: () {},
                ),
              ],
            ),
            const Text(
              'おくすりのんだ？',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'お薬1',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'お薬2',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'お薬3',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'お薬4',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'お薬5',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
