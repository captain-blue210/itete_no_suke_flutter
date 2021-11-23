import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class PhotoInput extends StatefulWidget {
  final bool fromPainRecord;
  const PhotoInput({Key? key, this.fromPainRecord = false}) : super(key: key);

  @override
  _PhotoInputState createState() => _PhotoInputState();
}

class _PhotoInputState extends State<PhotoInput> {
  final ImagePicker _picker = ImagePicker();
  late PhotoService _photoService;
  late PainRecordRequestParam _painRecordRequestParam;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _photoService = context.read<PhotoService>();
    _painRecordRequestParam = context.read<PainRecordRequestParam>();
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            _onImageButtonPressed(ImageSource.camera, context: context);
            Navigator.of(context).pop();
          },
          child: const Text('カメラ'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _onImageButtonPressed(
              ImageSource.gallery,
              context: context,
              isMultiImage: true,
            );
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

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      _onPickMultiImage();
    } else {
      _onPickImage(source);
    }
  }

  void _onPickMultiImage() async {
    final images = await _picker.pickMultiImage();
    if (widget.fromPainRecord) {
      for (var image in images!) {
        _painRecordRequestParam.photos = image;
      }
    } else {
      _photoService.addPhotos(images);
    }
  }

  void _onPickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (widget.fromPainRecord) {
      _painRecordRequestParam.photos = image!;
    } else {
      _photoService.addPhotos([image!]);
    }
  }
}
