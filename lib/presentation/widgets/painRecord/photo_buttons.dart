import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/presentation/pages/photo/photo_input.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/src/provider.dart';

class PhotoButtons extends StatefulWidget {
  const PhotoButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<PhotoButtons> createState() => PhotoButtonsState();
}

class PhotoButtonsState extends State<PhotoButtons> {
  @override
  Widget build(BuildContext context) {
    final existsChecked = context
        .watch<PainRecordRequestParam>()
        .getPhotos()!
        .any((e) => e.deleted!);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.add_a_photo),
          label: const Text('写真を追加する'),
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.blue),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return PhotoInput(fromPainRecord: true);
              },
            );
          },
        ),
        TextButton.icon(
          icon: const Icon(Icons.delete),
          label: const Text('写真を削除する'),
          style: TextButton.styleFrom(
            primary: existsChecked ? Colors.red : Colors.grey,
          ),
          onPressed: existsChecked
              ? () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('削除しますか？'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              context
                                  .read<PainRecordsService>()
                                  .deletePainRecordPhotos(
                                      context.read<PainRecordRequestParam>());

                              for (var photo in context
                                  .read<PainRecordRequestParam>()
                                  .getPhotos()!) {
                                final deletedList = context
                                    .read<PainRecordRequestParam>()
                                    .getPhotos()!
                                    .where((e) => e.deleted!)
                                    .toList();
                                context
                                    .read<PainRecordRequestParam>()
                                    .deleteDeletedPhotos(deletedList);
                              }
                            });
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text('削除'),
                        ),
                      ],
                    ),
                  )
              : null,
        ),
      ],
    );
  }
}
