import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/src/provider.dart';

class NewPainReocrdPhotoHolder extends StatefulWidget {
  const NewPainReocrdPhotoHolder({Key? key}) : super(key: key);

  @override
  State<NewPainReocrdPhotoHolder> createState() =>
      _NewPainReocrdPhotoHolderState();
}

class _NewPainReocrdPhotoHolderState extends State<NewPainReocrdPhotoHolder> {
  @override
  Widget build(BuildContext context) {
    var existPhoto =
        context.watch<PainRecordRequestParam>().getPhotos()!.isNotEmpty;
    var photos = context.watch<PainRecordRequestParam>().getPhotos()!;
    photos.sort((a, b) => a.image.hashCode.compareTo(b.image.hashCode));

    return Row(
      children: [
        existPhoto
            ? SizedBox(
                height: 240,
                width: 350,
                child: PageView.builder(
                  key: UniqueKey(),
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return Builder(
                      builder: (context) => Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: const Border(
                                left:
                                    BorderSide(color: Colors.white, width: 10),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    FileImage(File(photos[index].image!.path)),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: photos.isNotEmpty
                                ? () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: const Text('削除しますか？'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('キャンセル'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                            child: const Text('削除'),
                                            onPressed: () {
                                              final deletedList = photos
                                                  .where((e) =>
                                                      e.image!.path ==
                                                      photos[index].image!.path)
                                                  .toList();

                                              context
                                                  .read<
                                                      PainRecordRequestParam>()
                                                  .deleteNewPhotos(deletedList);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                : null,
                          ),
                          // NewPainRecordPhotoCheckBox(
                          //   registered: photos[index],
                          // )
                          // PhotoCheckBox(registered: snapshot.data![index]),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
