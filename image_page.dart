import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  String imgBig;
  String name;
  ImagePage({this.imgBig, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),

        //Простая картинка
        //body: Image(
        //    image: NetworkImage(imgBig),
        //),

        //Картинка с photo view
        body: PhotoView(
          imageProvider: NetworkImage(imgBig),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.contained * 4.0,
        ),
    );
  }
}