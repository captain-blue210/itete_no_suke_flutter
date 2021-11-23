import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itete_no_suke/presentation/pages/photo/photo_detail.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({
    Key? key,
    required this.photoURL,
    this.fromPainRecord = false,
  }) : super(key: key);

  final String photoURL;
  final bool fromPainRecord;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoDetail(photoURL: photoURL),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _getImage(fromPainRecord),
          ),
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
}
