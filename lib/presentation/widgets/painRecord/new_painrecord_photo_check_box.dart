import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/provider.dart';

class NewPainRecordPhotoCheckBox extends StatefulWidget {
  final Photo registered;
  const NewPainRecordPhotoCheckBox({Key? key, required this.registered})
      : super(key: key);

  @override
  State<NewPainRecordPhotoCheckBox> createState() => _PhotoCheckBoxState();
}

class _PhotoCheckBoxState extends State<NewPainRecordPhotoCheckBox> {
  @override
  Widget build(BuildContext context) {
    var photos = context.read<PainRecordRequestParam>().getPhotos();
    return Checkbox(
      tristate: true,
      shape: const CircleBorder(),
      value: context.read<PainRecordRequestParam>().getPhotos()!.isNotEmpty
          ? photos!
              .firstWhere((e) => e.image?.path == widget.registered.image?.path)
              .deleted
          : false,
      onChanged: (value) {
        var original = photos!
            .firstWhere((e) => e.image?.path == widget.registered.image?.path);

        context
            .read<PainRecordRequestParam>()
            .addNewPhoto(original.copyWith(deleted: !original.deleted!));
      },
      activeColor: Colors.lightBlue,
    );
  }
}
