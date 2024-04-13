import 'dart:math';

import 'package:brain_game/graphics/particle.dart';
import 'package:flutter/material.dart';

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;

  // double animValue;
  Random rdn;

  MyPainterCanvas(this.rdn, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((p) {
      var paint = Paint();
      paint.blendMode = BlendMode.modulate;
      paint.color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
