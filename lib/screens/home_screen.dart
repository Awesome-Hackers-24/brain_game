import 'package:brain_game/screens/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sensor Data")),
      body: Center(
        child: Obx(() {
          List<Widget> posWidgets = [];
          controller.data.forEach((key, value) {
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
      ),
    );
  }
}
