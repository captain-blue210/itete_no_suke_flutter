import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:provider/src/provider.dart';

class PhotoInput extends StatefulWidget {
  const PhotoInput({Key? key}) : super(key: key);

  @override
  _PhotoInputState createState() => _PhotoInputState();
}

class _PhotoInputState extends State<PhotoInput> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(
                  ImageSource.gallery,
                  context,
                );
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(
                  ImageSource.camera,
                  context,
                );
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source, BuildContext context) async {
    await _displayPickImageDialog(context, () async {
      await _picker
          .pickMultiImage()
          .then((images) => context.read<PhotoService>().addPhotos(images));
    });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, Function onPick) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sample'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('PICK'),
              onPressed: () {
                onPick();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
