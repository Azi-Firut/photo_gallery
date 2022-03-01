import 'package:flutter/material.dart';

import '../constants/constant.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

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
        // Center(
        //   heightFactor: 1.1,
        //   child: FloatingActionButton(
        //       backgroundColor: Colors.orange,
        //       child: Icon(Icons.shopping_basket),
        //       elevation: 0.1,
        //       onPressed: () {}),
        // ),
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

    path.moveTo(0, -15); // Start // left top corner
    path.quadraticBezierTo(0, 0, 15, 0); // left top corner
    path.lineTo(size.width - 15, 0); // line center
    path.moveTo(size.width - 15, 0); //right corner

    path.quadraticBezierTo(size.width, 0, size.width, -15); //right top corner

    path.lineTo(size.width, size.height + 20); // right line
    path.lineTo(0, size.height + 20); // bottom line
    path.lineTo(0, -15); // End // left line

    // Shadow path
    Path pathShadow = Path();

    pathShadow.moveTo(0, -25); // Start // left top corner
    pathShadow.quadraticBezierTo(0, -10, 25, -10); // left top corner
    pathShadow.lineTo(size.width - 25, -10); // line center
    pathShadow.moveTo(size.width - 25, -10); //right corner

    pathShadow.quadraticBezierTo(
        size.width, -10, size.width, -25); //right top corner

    pathShadow.lineTo(size.width, size.height + 20); // right line
    pathShadow.lineTo(0, size.height + 20); // bottom line
    pathShadow.lineTo(0, -25); // End // left line

    canvas.drawShadow(pathShadow, Colors.black, 3, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
