import 'dart:math';

import 'package:brain_game/graphics/blob_builder.dart';
import 'package:brain_game/graphics/my_painter_canvas.dart';
import 'package:brain_game/graphics/particle.dart';
import 'package:brain_game/screens/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPainter extends StatefulWidget {
  const MyPainter({super.key});

  @override
  State<MyPainter> createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> with TickerProviderStateMixin {
  List<Particle> particles = <Particle>[];
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationController radiusController; // Controller for radiusFactor
  late Animation<double> radiusAnimation; // Animation for radiusFactor
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  int particleCount = 70;
  double maxRadius = 6;
  double maxSpeed = 0.2;
  double maxTheta = 2 * pi;
  double t = 0;
  double dt = 0.01;
  double radiusFactor = 7;
  double text = 1234;

  final HomeController dataController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    BlobBuilder blobBuilder = BlobBuilder(particles, rgn);

    // Main animation controller for the blob
    controller = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        if (blobBuilder.particles.length == 0) {
          blobBuilder.createBlobField(context);
        }
        setState(() {
          t += dt;
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

    // Animation controller for smooth transitions of radiusFactor
    radiusController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    radiusAnimation = Tween<double>(begin: radiusFactor, end: radiusFactor).animate(radiusController)
      ..addListener(() {
        setState(() {
          radiusFactor = radiusAnimation.value;
        });
      });

    ever(dataController.data, handleDataChange);
  }

  void handleDataChange(Map<String, dynamic> data) {
    double newRadiusFactor = normalize(data['pos1'], data['pos2'], data['pos3']).toDouble();
    radiusAnimation = Tween<double>(begin: radiusFactor, end: newRadiusFactor).animate(CurvedAnimation(parent: radiusController, curve: Curves.easeInOut));
    radiusController
      ..reset()
      ..forward();
  }

  int normalize(double pos1, double pos2, double pos3) {
    double p1 = (pos1 / 10000).abs();
    double p2 = (pos2 / 10000).abs();
    double p3 = (pos3 / 10000).abs();
    int result;
    if (p1 > 470) {
      result = (p1 % 10 - p1 ~/ 100).toInt().abs();
    } else if (p2 > 590 && p3 > 550) {
      result = (p2 ~/ 100 + p3 % 100).toInt().abs();
    } else {
      result = (p2 ~/ 100).abs();
    }
    return result.abs();
  }

  @override
  void dispose() {
    controller.dispose();
    radiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: MyPainterCanvas(rgn, particles),
        child: Column(
          children: [
            debugData(),
            const SizedBox(height: 50),
            Slider(
              value: radiusFactor,
              min: 0,
              max: 10,
              onChanged: (v) {
                setState(() {
                  radiusFactor = v;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Row debugData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() {
          List<Widget> posWidgets = [];
          dataController.data.forEach((key, value) {
            if (key.startsWith('pos')) {
              posWidgets.add(
                Text('$key: ${value.toString()}'),
              );
            }
          });

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: posWidgets,
            ),
          );
        }),
      ],
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
