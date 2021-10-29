import 'package:flutter/material.dart';
import 'package:itete_no_suke/view/widgets/photo/photo_grid_item_list.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({Key? key}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    return PhotoGridItemList();
  }
}
