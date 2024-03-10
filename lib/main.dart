import 'package:flutter/material.dart';
import 'package:weather_application/Scrrens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0664F2)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
