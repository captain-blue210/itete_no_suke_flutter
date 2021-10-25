import 'package:flutter/material.dart';

class PainRecordInput extends StatefulWidget {
  const PainRecordInput({Key? key}) : super(key: key);

  @override
  _PainRecordInputState createState() => _PainRecordInputState();
}

class _PainRecordInputState extends State<PainRecordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
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
              const Text(
                '痛いところは？',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'メモ',
                    )),
              ]),
              const Text(
                'メモ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SizedBox(
                  height: 100,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'メモ',
                    ),
                  ),
                ),
              ]),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                color: Colors.grey,
                iconSize: 50,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
