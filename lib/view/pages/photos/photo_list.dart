import 'package:flutter/material.dart';
import 'package:itete_no_suke/view/pages/photos/photo_detail.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({Key? key}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  var imageList = [
    'images/2532x1170.png',
    'images/IMG_3847.jpeg',
    'images/2532x1170.png',
    'images/2532x1170.png',
    'images/2532x1170.png',
    'images/2532x1170.png',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 3,
      ),
      itemCount: imageList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoDetail(
                  imageName: imageList[index],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imageList[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
