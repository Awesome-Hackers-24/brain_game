import 'dart:math';

import 'package:brain_game/graphics/my_painter_canvas.dart';
import 'package:brain_game/graphics/particle.dart';
import 'package:flutter/material.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

Color getRandomColor(Random rgn) {
  var a = rgn.nextInt(255);
  var r = rgn.nextInt(255);
  var g = rgn.nextInt(255);
  var b = rgn.nextInt(255);

  return Color.fromARGB(a, r, g, b);
}

Color getColor(Random rgn, double d, double a) {
  var a = 255;
  var r = ((sin(d * 2 * pi) * 127.0 + 127.0)).toInt();
  var g = ((cos(d * 2 * pi) * 127.0 + 127.0)).toInt();
  var b = rgn.nextInt(255);

  return Color.fromARGB(a, r, g, b);
}

class _MyPainterState extends State<MyPainter> with SingleTickerProviderStateMixin {
  List<Particle> particles = <Particle>[];
  late Animation<double> animation;
  late AnimationController controller;

  int particleCount = 100;

  // List.generate(10, (index) => Particle());
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        if (particles.length == 0) {
          createBlobField();
        }
        setState(() {
          updateBlobField();
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

    // particles = List.generate(10, (index) {
    //   Particle p = Particle();
    //   p.color = getRandomColor(rgn);
    //   p.position = Offset(-1, -1);
    //   p.speed = rgn.nextDouble() * maxSpeed;
    //   p.theta = rgn.nextDouble() * maxTheta;
    //   p.radius = rgn.nextDouble() * maxRadius;
    //   return p;
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double maxRadius = 6;
  double maxSpeed = 0.2;
  double maxTheta = 2 * pi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Brain Game"),
      // ),
      body: CustomPaint(
        child: Column(
          children: [
            SizedBox(height: 50),
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
        painter: MyPainterCanvas(rgn, particles),
      ),
    );
  }

  void createBlobField() {
    final size = MediaQuery.of(context).size;
    //center of the screen
    final o = Offset(size.width / 2, size.height / 2);
    //number of blobs
    final n = 7;
    //radius of the blob
    final r = size.width / n;
    //alpha blending value
    final a = 0.2;
    blobField(r, n, a, o);
  }

  void blobField(double r, int n, double a, Offset o) {
    //exit strategy for recursion
    if (r < 10) return;
    particles.add(Particle()
      ..radius = r / n
      ..theta = 0
      ..position = o
      ..origin = o
      ..color = Colors.black);
    //add orbital blobs
    var theta = 0.0; //angle of the arc
    var dTheta = 2 * pi / n; // angle between child blobs

    for (var i = 0; i < n; i++) {
      //get position of the child blob
      var pos = polarToCartesian(r, theta) + o;
      //create the new child particle
      particles.add(Particle()
        ..theta = theta
        ..position = pos
        ..origin = o
        ..radius = r / n //radius of the child is 1/3 of the orbit
        ..color = getColor(rgn, i.toDouble() / n, a));

      //increment the angle
      theta += dTheta;
      var f = 0.43;
      blobField(r * f, n, a * 1.5, pos);
    }
  }

  double t = 0;
  double dt = 0.01;
  double radiusFactor = 7;

  void updateBlobField() {
    t += dt;
    // radiusFactor = mapRange(sin(t), -1, 1, 2, 10);
    //move the particles around
    particles.forEach((p) {
      p.position = polarToCartesian(p.radius * radiusFactor, p.theta + t) + p.origin;
    });
  }

  // double mapRange(double value, double min1, double max1, double min2, double max2) {
  //   double range1 = min1 - max1;
  //   double range2 = min2 - max2;
  //   return min2 + range2 * value / range1;
  // }
}
