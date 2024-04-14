import 'dart:math';

import 'package:brain_game/graphics/my_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/focus.png'), // Ensure the image path is correct
            fit: BoxFit.cover, // This will cover the entire screen
          ),
        ),
        child: Center( // Center the card on the screen
          child: Container(
            width: min(MediaQuery.of(context).size.width, 600), // Max width for the card
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7), // Slightly more opaque for better readability
              borderRadius: BorderRadius.circular(12), // Smooth rounded corners
              boxShadow: [ // Optional: adds elevation to the card
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Fit content in the smallest space
              children: [
                Text(
                  "Improve Your Concentration",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Focus the animated dots to the center by maintaining your concentration.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => MyPainter());
                  },
                  child: Text('Start Challenge'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
