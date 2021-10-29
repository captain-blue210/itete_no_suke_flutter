import 'package:flutter/material.dart';
import 'package:itete_no_suke/view/widgets/photo/hero_photo_view_route_wrapper.dart';

class PhotoDetail extends StatelessWidget {
  const PhotoDetail({Key? key, required this.imageName}) : super(key: key);
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('いててのすけ'),
      ),
      body: Container(
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
                            imageProvider: AssetImage(imageName)),
                      ),
                    );
                  },
                  child: Container(
                    child: Hero(
                      tag: imageName,
                      child: Image.asset(imageName),
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
}
