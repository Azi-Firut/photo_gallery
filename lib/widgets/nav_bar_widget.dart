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
      ..strokeWidth = 1
      ..color = kAllBarColor
      ..style = PaintingStyle.fill;

    Path path = Path();

    ///path.quadraticBezierTo(bx, by, y, x);
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

    ///path.quadraticBezierTo(bx, by, y, x);
    pathShadow.moveTo(0, -35); // Start // left top corner
    pathShadow.quadraticBezierTo(0, -10, 15, -10); // left top corner
    pathShadow.lineTo(size.width - 15, -10); // line center
    pathShadow.moveTo(size.width - 15, -10); //right corner

    pathShadow.quadraticBezierTo(
        size.width, -10, size.width, -35); //right top corner

    pathShadow.lineTo(size.width, size.height + 35); // right line
    pathShadow.lineTo(0, size.height + 25); // bottom line
    pathShadow.lineTo(0, -35); // End // left line

    canvas.drawShadow(pathShadow, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
