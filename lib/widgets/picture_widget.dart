import '../constants/constant.dart';
import 'package:flutter/material.dart';
import '../screens/image_screen.dart';

class PictureGrid extends StatelessWidget {
  late String imagesUrl;

  PictureGrid(
      {Key? key, //required this.index,
      required this.imagesUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 7,
          primary: kButtonColor,
        ),
        onPressed: () {
          if ((imagesUrl) == null) {
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageScreen(img: imagesUrl),
              ),
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            imagesUrl,
            cacheHeight: 10,
            isAntiAlias: true,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, exception, stackTrace) => Image.asset(
              'assets/images/no_image.png',
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white10,
                  strokeWidth: 7,
                  color: kColorOther,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
