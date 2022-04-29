import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/provider.dart';

class PhotoCheckBox extends StatefulWidget {
  final Photo registered;
  const PhotoCheckBox({Key? key, required this.registered}) : super(key: key);

  @override
  State<PhotoCheckBox> createState() => _PhotoCheckBoxState();
}

class _PhotoCheckBoxState extends State<PhotoCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PainRecordRequestParam>(
      builder: (context, param, child) {
        if (!param.getPhotos()!.any((e) => e.id == widget.registered.id)) {
          param.initPhotos(widget.registered);
        }
        return Checkbox(
          shape: const CircleBorder(),
          value: param.getPhotos()!.isNotEmpty
              ? param
                  .getPhotos()!
                  .firstWhere((e) => e.id == widget.registered.id)
                  .deleted
              : false,
          onChanged: (value) {
            var original = param
                .getPhotos()!
                .firstWhere((e) => e.id == widget.registered.id);

            param.photos = original.copyWith(deleted: !original.deleted!);
          },
          activeColor: Colors.lightBlue,
        );
      },
    );
  }
}
