import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/photo/photo.dart';

class PhotoHolder extends StatefulWidget {
  final List<Photo>? registered;
  const PhotoHolder({Key? key, this.registered}) : super(key: key);

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
    if (widget.registered!.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: PageView.builder(
        key: UniqueKey(),
        padEnds: false,
        controller: PageController(viewportFraction: 0.8),
        itemCount: widget.registered!.length,
        itemBuilder: (context, index) {
          return Builder(
            builder: (context) => Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                    decoration: BoxDecoration(
                  border: const Border(
                      left: BorderSide(color: Colors.white, width: 10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _getImage(false, widget.registered![index].photoURL),
                  ),
                )),
                Checkbox(
                  shape: const CircleBorder(),
                  tristate: false,
                  value: true,
                  onChanged: (value) => value,
                  activeColor: Colors.lightBlue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ImageProvider<Object> _getImage(bool doRegist, String photoURL) {
    if (doRegist) {
      return FileImage(File(photoURL));
    } else {
      return NetworkImage(photoURL);
    }
  }
}
