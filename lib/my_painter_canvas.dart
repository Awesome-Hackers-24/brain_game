import 'package:flutter/material.dart';

class MyPainterCanvas extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dx = size.width/2;
    var dy = size.height/2;
    Offset c = Offset(dx, dy);
    var radius = 100.0;
    var paint = Paint();
    paint.color = Colors.teal;
    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
