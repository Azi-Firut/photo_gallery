import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: Size(size.width, 0),
          foregroundPainter: BottomCustomPainter(),
        ),
      ],
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

    path.moveTo(0, 40); // Start // left top corner
    path.quadraticBezierTo(0, 25, 15, 25); // left top corner
    path.lineTo(size.width - 15, 25); // line center
    path.moveTo(size.width - 15, 25); //right corner
    path.quadraticBezierTo(size.width, 25, size.width, 40); //right top corner
    path.lineTo(size.width, size.height - 40); // right line
    path.lineTo(0, size.height - 40); // bottom line
    path.lineTo(0, 40); // End // left line

    // Shadow path
    Path pathShadow = Path();

    pathShadow.moveTo(0, 50); // Start // left top corner
    pathShadow.quadraticBezierTo(0, 37, 15, 30); // left top corner
    pathShadow.lineTo(size.width - 25, 30); // line center
    pathShadow.moveTo(size.width - 25, 30); //right corner

    pathShadow.quadraticBezierTo(
        size.width, 30, size.width, 50); //right top corner

    pathShadow.lineTo(size.width, size.height - 50); // right line
    pathShadow.lineTo(0, size.height - 50); // bottom line
    pathShadow.lineTo(0, 50); // End // left line

    canvas.drawShadow(pathShadow, Colors.black, 3, false); //2
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
