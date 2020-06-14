import 'package:flutter/material.dart';
import 'package:unsplash001/unsplash_list.dart';

void main() {
  runApp(UnsplashViewer());
}

class UnsplashViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UnsplashList()
    );
  }
}
