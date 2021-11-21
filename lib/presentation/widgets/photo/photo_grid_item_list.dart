import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/model/photo/photo.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_grid_item.dart';
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
      stream: context.read<PhotoService>().getPhotosByUserID(),
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
                return PhotoGridItem(photo: snapshot.data!.docs[index].data());
              });
        } else {
          return const Center(
            child: Text('写真が登録がされていません。'),
          );
        }
      },
    );
  }
}
