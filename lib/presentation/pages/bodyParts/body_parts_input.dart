import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/model/bodyParts/body_parts_service.dart';
import 'package:provider/src/provider.dart';

class BodyPartsInput extends StatefulWidget {
  const BodyPartsInput({Key? key}) : super(key: key);

  @override
  _BodyPartsInputState createState() => _BodyPartsInputState();
}

class _BodyPartsInputState extends State<BodyPartsInput> {
  final addBodyPartController = TextEditingController();
  late FocusNode addBodyPartFocusNode;

  @override
  void initState() {
    super.initState();
    addBodyPartFocusNode = FocusNode();
  }

  @override
  void dispose() {
    addBodyPartController.dispose();
    addBodyPartFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyPartsService = context.read<BodyPartsService>();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                autofocus: true,
                onEditingComplete: () async {
                  if (addBodyPartController.text.isNotEmpty) {
                    final bodyPart = BodyPart(name: addBodyPartController.text);
                    bodyPartsService.addNewBodyPart(bodyPart);
                  }
                  addBodyPartController.clear();
                  addBodyPartFocusNode.unfocus();
                  Navigator.pop(context);
                },
                controller: addBodyPartController,
                focusNode: addBodyPartFocusNode,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '痛む部位の名前'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
