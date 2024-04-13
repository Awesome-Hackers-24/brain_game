import 'dart:math';

import 'package:brain_game/graphics/particle.dart';
import 'package:flutter/material.dart';

class BlobBuilder {
  List<Particle> particles = <Particle>[];
  Random rgn;

  BlobBuilder(this.particles, this.rgn);

  void createBlobField(BuildContext context) {
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
}
