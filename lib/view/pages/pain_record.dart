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
          ],
        ),
      ),
    );
  }
}
