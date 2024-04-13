import 'package:brain_game/app.dart';
import 'package:brain_game/get_bindings.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await GetBindings.init();
  runApp(const MyApp());
}
