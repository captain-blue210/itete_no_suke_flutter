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
          children: [Text('痛み')],
        ),
      ),
    );
  }
}
