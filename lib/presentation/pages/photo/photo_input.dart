import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/src/provider.dart';

class PhotoInput extends StatefulWidget {
  final bool fromPainRecord;
  const PhotoInput({Key? key, this.fromPainRecord = false}) : super(key: key);

  @override
  _PhotoInputState createState() => _PhotoInputState();
}

class _PhotoInputState extends State<PhotoInput> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final painRecordId = context.read<PainRecordRequestParam>().id;
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () async {
            final image = await _picker.pickImage(source: ImageSource.camera);

            var param = PainRecordRequestParam();
            param.id = painRecordId;
            if (widget.fromPainRecord) {
              param.initPhotos(Photo(image: image));
              context.read<PainRecordsService>().addPainRecordPhotos(param);
            } else {
              context.read<PhotoService>().addPhotos([image!]);
            }

            Navigator.of(context).pop();
          },
          child: const Text('カメラ'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            final images = await _picker.pickMultiImage();

            var param = PainRecordRequestParam();
            param.id = painRecordId;
            if (widget.fromPainRecord) {
              for (var image in images!) {
                param.initPhotos(Photo(image: image));
              }
              context.read<PainRecordsService>().addPainRecordPhotos(param);
            } else {
              context.read<PhotoService>().addPhotos(images);
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
