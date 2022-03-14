import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class MemoInput extends StatefulWidget {
  final String? registered;
  const MemoInput({Key? key, this.registered}) : super(key: key);

  @override
  _MemoInputState createState() => _MemoInputState();
}

class _MemoInputState extends State<MemoInput> {
  final addMemoController = TextEditingController();
  late FocusNode addMemoFocusNode = FocusNode();

  @override
  void initState() {
    addMemoFocusNode.addListener(() {
      if (!addMemoFocusNode.hasFocus && addMemoController.text.isNotEmpty) {
        context.read<PainRecordRequestParam>().memo = addMemoController.text;
      }
    });

    if (addMemoController.text.isEmpty && widget.registered != null) {
      addMemoController.text = widget.registered!;
    }
    super.initState();
  }

  @override
  void dispose() {
    addMemoController.dispose();
    addMemoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'メモ',
          ),
          controller: addMemoController,
          focusNode: addMemoFocusNode,
        ),
      ],
    );
  }
}
