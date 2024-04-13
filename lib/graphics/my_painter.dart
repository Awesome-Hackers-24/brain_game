import 'dart:math';

import 'package:brain_game/graphics/my_painter_canvas.dart';
import 'package:brain_game/graphics/particle.dart';
import 'package:flutter/material.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  late List<Particle> particles;

  // List.generate(10, (index) => Particle());
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);
  double maxRadius = 6;
  double maxSpeed = 0.2;
  double maxTheta = 2 * pi;

  @override
  void initState() {
    super.initState();
    particles = List.generate(10, (index) {
      Particle p = Particle();
      p.color = getRandomColor(rgn);
      p.position = Offset(-1, -1);
      p.speed = rgn.nextDouble() * maxSpeed;
      p.theta = rgn.nextDouble() * maxTheta;
      p.radius = rgn.nextDouble() * maxRadius;
      return p;
    });
  }

  Color getRandomColor(Random rgn) {
    var a = rgn.nextInt(255);
    var r = rgn.nextInt(255);
    var g = rgn.nextInt(255);
    var b = rgn.nextInt(255);

    return Color.fromARGB(a, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Brain Game"),
      // ),
      body: CustomPaint(
        painter: MyPainterCanvas(rgn, particles),
        child: Container(
            // color: Colors.deepOrangeAccent,
            ),
      ),
    );
  }
}
