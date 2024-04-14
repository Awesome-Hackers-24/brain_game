import 'package:brain_game/graphics/my_painter.dart';
import 'package:brain_game/screens/home_screen.dart';
import 'package:brain_game/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Brain Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IntroScreen(),
      // home: const MyPainter(),
      // home: const HomeScreen(),
    );
  }
}
