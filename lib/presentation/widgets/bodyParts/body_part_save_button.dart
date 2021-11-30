import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:provider/src/provider.dart';

class BodyPartSaveButton extends StatefulWidget {
  final DocumentReference<BodyPart>? ref;
  final TextEditingController name;
  final TextEditingController memo;
  const BodyPartSaveButton({
    Key? key,
    required this.ref,
    required this.name,
    required this.memo,
  }) : super(key: key);

  @override
  _BodyPartSaveButtonState createState() => _BodyPartSaveButtonState();
}

class _BodyPartSaveButtonState extends State<BodyPartSaveButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 50,
          child: TextButton(
            child: isLoading
                ? const SizedBox(
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text('保存',
                    style: TextStyle(
                      color: Colors.white,
                    )),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              BodyPart bodyPart = BodyPart(
                name: widget.name.text,
                memo: widget.memo.text,
              );
              bodyPart.bodyPartRef = widget.ref;
              bodyPart.bodyPartsID = widget.ref!.id;
              context.read<BodyPartsService>().updateBodyPart(bodyPart);
              await Future.delayed(Duration(seconds: 2));
              setState(() {
                isLoading = false;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
          ),
        )
      ],
    );
  }
}
