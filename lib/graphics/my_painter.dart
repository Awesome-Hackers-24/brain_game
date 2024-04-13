import 'dart:math';

import 'package:brain_game/graphics/blob_builder.dart';
import 'package:brain_game/graphics/my_painter_canvas.dart';
import 'package:brain_game/graphics/particle.dart';
import 'package:flutter/material.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> with SingleTickerProviderStateMixin {
  List<Particle> particles = <Particle>[];
  late Animation<double> animation;
  late AnimationController controller;
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  int particleCount = 70;
  double maxRadius = 6;
  double maxSpeed = 0.2;
  double maxTheta = 2 * pi;
  double t = 0;
  double dt = 0.01;
  double radiusFactor = 7;

  @override
  void initState() {
    super.initState();
    BlobBuilder blobBuilder = BlobBuilder(particles, rgn);

    controller = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        if (blobBuilder.particles.length == 0) {
          blobBuilder.createBlobField(context);
        }
        setState(() {
          t += dt;
          // radiusFactor = mapRange(sin(t), -1, 1, 2, 10);
          updateBlobField(blobBuilder);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        child: Column(
          children: [
            const SizedBox(height: 50),
            Slider(
              value: radiusFactor,
              min: 1,
              max: 10,
              onChanged: (v) {
                setState(() {
                  radiusFactor = v;
                });
              },
            )
          ],
          // color: Colors.deepOrangeAccent,
        ),
      ),
    );
  }

  void updateBlobField(BlobBuilder blobBuilder) {
    //move the particles around
    blobBuilder.particles.forEach((p) {
      p.position = blobBuilder.polarToCartesian(p.radius * radiusFactor, p.theta + t) + p.origin;
    });
  }

// double mapRange(double value, double min1, double max1, double min2, double max2) {
//   double range1 = min1 - max1;
//   double range2 = min2 - max2;
//   return min2 + range2 * value / range1;
// }
}
