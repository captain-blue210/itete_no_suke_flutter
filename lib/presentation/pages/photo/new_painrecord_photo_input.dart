import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/src/provider.dart';

class NewPainRecordPhotoInput extends StatefulWidget {
  const NewPainRecordPhotoInput({Key? key}) : super(key: key);

  @override
  _PhotoInputState createState() => _PhotoInputState();
}

class _PhotoInputState extends State<NewPainRecordPhotoInput> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () async {
            final image = await _picker.pickImage(source: ImageSource.camera);

            context
                .read<PainRecordRequestParam>()
                .addNewPhoto(Photo(image: image, deleted: false));

            Navigator.of(context).pop();
          },
          child: const Text('カメラ'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            final images = await _picker.pickMultiImage();

            for (var image in images!) {
              context
                  .read<PainRecordRequestParam>()
                  .addNewPhoto(Photo(image: image, deleted: false));
            }

            Navigator.of(context).pop();
          },
          child: const Text('フォトライブラリ'),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('キャンセル'),
      ),
    );
  }
}
