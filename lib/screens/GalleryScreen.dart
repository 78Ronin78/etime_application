import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<String> _imageList = [
    'assets/gallery/1.jpg',
    'assets/gallery/2.jpg',
    'assets/gallery/3.jpg',
    'assets/gallery/4.jpg',
    'assets/gallery/5.jpg',
    'assets/gallery/6.jpg',
    'assets/gallery/7.jpg',
    'assets/gallery/8.jpg',
    'assets/gallery/9.jpg',
    'assets/gallery/10.jpg',
    'assets/gallery/11.jpg',
    'assets/gallery/12.jpg',
    'assets/gallery/13.jpg',
    'assets/gallery/14.jpg',
    'assets/gallery/15.jpg',
    'assets/gallery/16.jpg',
    'assets/gallery/17.jpg',
    'assets/gallery/18.jpg',
    'assets/gallery/19.jpg',
    'assets/gallery/20.jpg',
    'assets/gallery/21.jpg',
    'assets/gallery/22.jpg',
    'assets/gallery/23.jpg',
    'assets/gallery/24.jpg',
    'assets/gallery/25.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(_imageList[index]),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: _imageList[index]),
        );
      },
      itemCount: _imageList.length,
    ));
  }
}
