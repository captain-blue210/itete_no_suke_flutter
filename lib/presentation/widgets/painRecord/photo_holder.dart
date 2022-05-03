import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/painRecord/pain_records_service.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/photo_check_box.dart';
import 'package:provider/src/provider.dart';

class PhotoHolder extends StatefulWidget {
  const PhotoHolder({Key? key}) : super(key: key);

  @override
  State<PhotoHolder> createState() => _PhotoHolderState();
}

class _PhotoHolderState extends State<PhotoHolder> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Photo>?>(
        stream: context
            .watch<PainRecordsService>()
            .getPhotosByPainRecordID(context.read<PainRecordRequestParam>()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Row(
            children: [
              SizedBox(
                height: 240,
                width: 350,
                child: PageView.builder(
                  key: UniqueKey(),
                  padEnds: false,
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Builder(
                      builder: (context) => Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: const Border(
                                  left: BorderSide(
                                      color: Colors.white, width: 10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _getImage(
                                    false, snapshot.data![index].photoURL!),
                              ),
                            ),
                          ),
                          PhotoCheckBox(registered: snapshot.data![index]),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        });
  }

  ImageProvider<Object> _getImage(bool doRegist, String photoURL) {
    if (doRegist) {
      return FileImage(File(photoURL));
    } else {
      return NetworkImage(photoURL);
    }
  }
}
