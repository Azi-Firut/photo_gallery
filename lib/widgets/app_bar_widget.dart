import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter, //MediaQuery.of(context).size.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 0),
            foregroundPainter: BottomCustomPainter(),
          ),
        ],
      ),
    );
  }
}

class BottomCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = kAllBarColor
      ..style = PaintingStyle.fill;

    Path path = Path();

    ///path.quadraticBezierTo(bx, by, y, x);
    path.moveTo(0, 15); // Start // left top corner
    path.quadraticBezierTo(0, 0, 15, 0); // left top corner
    path.lineTo(size.width - 15, 0); // line center
    path.moveTo(size.width - 15, 0); //right corner
    path.quadraticBezierTo(size.width, 0, size.width, 15); //right top corner
    path.lineTo(size.width, size.height - 70); // right line
    path.lineTo(0, size.height - 70); // bottom line
    path.lineTo(0, 15); // End // left line

    // Shadow path
    Path pathShadow = Path();

    pathShadow.moveTo(0, 15); // Start // left top corner
    pathShadow.quadraticBezierTo(0, 0, 15, 0); // left top corner
    pathShadow.lineTo(size.width - 15, 0); // line center
    pathShadow.moveTo(size.width - 15, 0); //right corner
    pathShadow.quadraticBezierTo(
        size.width, 0, size.width, 15); //right top corner
    pathShadow.lineTo(size.width, size.height - 70); // right line
    pathShadow.lineTo(0, size.height - 70); // bottom line
    pathShadow.lineTo(0, 15); // End // left line

    canvas.drawShadow(pathShadow, Colors.black, 10, true); //3
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
