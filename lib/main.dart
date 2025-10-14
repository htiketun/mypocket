import 'package:flutter/material.dart';
import 'home.dart';
import 'arcade_theme.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyPocket Arcade',
      theme: arcadeTheme,
      home: HomeScreen(),
    ),
  );
}

class MyPocketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPocket Arcade',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: HomeScreen(),
    );
  }
}

