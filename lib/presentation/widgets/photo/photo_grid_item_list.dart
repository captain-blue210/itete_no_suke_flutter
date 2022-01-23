import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/request/photo/PhotoRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_grid_item.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_mode_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class PhotoGridItemList extends StatefulWidget {
  const PhotoGridItemList({Key? key}) : super(key: key);

  @override
  _PhotoGridItemListState createState() => _PhotoGridItemListState();
}

class _PhotoGridItemListState extends State<PhotoGridItemList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Photo>>(
      // TODO need to use real userID
      stream: context.watch<PhotoService>().getPhotosByUserID(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
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
                          PhotoGridItem(
                              photo: snapshot.data!.docs[index].data()),
                          Consumer<PhotoRequestParam>(
                            builder: (context, param, child) {
                              return getCheckBox(photoModeState, param,
                                  snapshot.data!.docs[index].data());
                            },
                          )
                        ]);
                  },
                );
              });
        } else {
          return const Center(
            child: Text('写真が登録がされていません。'),
          );
        }
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
