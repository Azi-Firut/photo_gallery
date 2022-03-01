import 'package:cached_network_image/cached_network_image.dart';
import '../constants/constant.dart';
import 'package:flutter/material.dart';
import '../screens/image_screen.dart';

class PictureGrid extends StatelessWidget {
  final int index;
  final List imagesUrl;

  const PictureGrid({Key? key, required this.index, required this.imagesUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CachedNetworkImage(
        width: double.infinity,
        fit: BoxFit.cover,
        imageUrl: imagesUrl[index] ?? kNoImageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
          padding: const EdgeInsets.all(30.0),
          child: CircularProgressIndicator(
              strokeWidth: 10,
              color: kColorOther,
              value: downloadProgress.progress),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/no_image.png',
          fit: BoxFit.cover,
        ),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: kBoxShadowColor,
                offset: Offset(
                  0.0,
                  4.0,
                ),
                blurRadius: 4.0,
                spreadRadius: 0.1,
              ),
            ],
            image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () {
              // try {
              //   print('x');
              // } on Exception catch (_) {
              //   print('never reached');
              // }
              //
              if ((imagesUrl[index]) == null) {
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(img: imagesUrl[index]),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
