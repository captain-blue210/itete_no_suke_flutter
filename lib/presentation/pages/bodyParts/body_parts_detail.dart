import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/bodyParts/body_parts_service.dart';
import 'package:itete_no_suke/model/bodyParts/body_part.dart';
import 'package:itete_no_suke/presentation/widgets/bodyParts/body_part_save_button.dart';
import 'package:provider/src/provider.dart';

class BodyPartsDetail extends StatefulWidget {
  final String bodyPartsID;
  const BodyPartsDetail({Key? key, required this.bodyPartsID})
      : super(key: key);

  @override
  _BodyPartsDetailState createState() => _BodyPartsDetailState();
}

class _BodyPartsDetailState extends State<BodyPartsDetail> {
  final _updateNameController = TextEditingController();
  final _updateMemoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('部位'),
      ),
      body: FutureBuilder<BodyPart>(
        future:
            context.read<BodyPartsService>().getBodyPart(widget.bodyPartsID),
        builder: (context, snapshot) {
          _updateNameController.text = snapshot.data!.name;
          _updateMemoController.text = snapshot.data!.memo!;
          if (snapshot.hasData) {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      children: [
                        const Text(
                          '部位名',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: _updateNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'メモ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            constraints: BoxConstraints.expand(height: 200),
                            border: OutlineInputBorder(),
                          ),
                          controller: _updateMemoController,
                        ),
                        BodyPartSaveButton(
                          ref: snapshot.data!.bodyPartRef,
                          name: _updateNameController,
                          memo: _updateMemoController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
