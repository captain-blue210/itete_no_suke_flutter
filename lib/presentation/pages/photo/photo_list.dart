import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/photo/PhotoRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/auth/auth_state.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_container.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_mode_state.dart';
import 'package:provider/provider.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({Key? key}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Photo>>(
      stream: context.watch<PhotoService>().getPhotosByUserID(),
      builder: (context, snapshot) {
        if (!context.watch<AuthState>().isLogin ||
            (context.watch<AuthState>().isLogin &&
                snapshot.data!.docs.isEmpty)) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.photo_album,
                      color: Colors.grey,
                      size: 100,
                    ),
                  ),
                  Text(
                    'まだ写真の登録がないようです。',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    '右下のボタンから写真を追加してみましょう🐯',
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          );
        }
        return SafeArea(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
              ),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return Consumer<PhotoModeState>(
                  builder: (context, photoModeState, child) {
                    return Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          PhotoContainer(
                              photoURL:
                                  snapshot.data!.docs[index].data().photoURL!),
                          Consumer<PhotoRequestParam>(
                            builder: (context, param, child) {
                              return getCheckBox(photoModeState, param,
                                  snapshot.data!.docs[index].data());
                            },
                          )
                        ]);
                  },
                );
              }),
        );
      },
    );
  }

  Widget getCheckBox(
      PhotoModeState state, PhotoRequestParam param, Photo photo) {
    if (state.isPhotoSelectMode && isChecked(context, photo)) {
      return Checkbox(
        shape: const CircleBorder(),
        tristate: false,
        value: true,
        onChanged: (value) => param.removeSelectedPhoto(photo),
        activeColor: Colors.lightBlue,
      );
    } else if (state.isPhotoSelectMode && !isChecked(context, photo)) {
      return Checkbox(
        shape: const CircleBorder(),
        tristate: false,
        value: false,
        onChanged: (value) => param.addSelectedPhoto(photo),
        activeColor: Colors.blueGrey,
      );
    } else {
      return Container();
    }
  }

  bool isChecked(BuildContext context, Photo target) {
    return context.read<PhotoRequestParam>().contains(target);
  }
}
