import 'dart:math';

import 'package:brain_game/graphics/particle.dart';
import 'package:flutter/material.dart';

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  double animValue;

  MyPainterCanvas(this.rdn, this.particles, this.animValue);

  List<Particle> particles;
  Random rdn;

  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((p) {
      var velocity = polarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;

      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rdn.nextDouble() * size.width;
      }

      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rdn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    });

    this.particles.forEach((p) {
      var paint = Paint();
      paint.color = Colors.teal;
      canvas.drawCircle(p.position, p.radius, paint);
    });

    var dx = size.width / 2;
    var dy = size.height / 2;
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
