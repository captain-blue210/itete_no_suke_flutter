import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/widgets/photo/hero_photo_view_route_wrapper.dart';

class PhotoDetail extends StatelessWidget {
  const PhotoDetail(
      {Key? key, required this.photoURL, this.fromPainRecord = false})
      : super(key: key);
  final String photoURL;
  final bool fromPainRecord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('いててのすけ'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeroPhotoViewRouteWrapper(
                          imageProvider: _getImage(fromPainRecord),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Hero(
                      tag: photoURL,
                      child: _getImageWidget(fromPainRecord),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> _getImage(bool fromPainRecord) {
    if (fromPainRecord) {
      return FileImage(File(photoURL));
    } else {
      return NetworkImage(photoURL);
    }
  }

  Widget _getImageWidget(bool fromPainRecord) {
    if (fromPainRecord) {
      return Image.file(File(photoURL));
    } else {
      return Image.network(photoURL);
    }
  }
}
