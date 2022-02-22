import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/constant.dart';

class ImageScreen extends StatelessWidget {
  final String img;

  const ImageScreen({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: img,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {},
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
    );
  }
}
