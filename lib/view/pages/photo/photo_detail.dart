import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    print(imageProvider.toString());
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: PhotoViewHeroAttributes(tag: imageProvider.toString()),
      ),
    );
  }
}
