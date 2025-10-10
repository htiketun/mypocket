import 'package:flutter/material.dart';

final arcadeTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFFFC466B),
  scaffoldBackgroundColor: const Color(0xFF0F2027),
  fontFamily: 'Arcade', // Make sure you add this font in pubspec.yaml!
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Arcade',
      fontSize: 32,
      color: Colors.amberAccent,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
    ),
    titleMedium: TextStyle(
      fontFamily: 'Arcade',
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Arcade',
      fontSize: 14,
      color: Colors.white70,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Arcade',
      fontSize: 28,
      color: Colors.amberAccent,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
    ),
    iconTheme: IconThemeData(color: Colors.amberAccent),
  ),
  cardTheme: CardThemeData(
    color: Colors.deepPurple.withOpacity(0.85),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    elevation: 8,
    shadowColor: Colors.amberAccent.withOpacity(0.2),
  ),
  iconTheme: const IconThemeData(color: Colors.amberAccent, size: 28),
  colorScheme:
      ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
        backgroundColor: const Color(0xFF0F2027),
      ).copyWith(
        secondary: Colors.amberAccent,
        primary: const Color(0xFFFC466B),
        background: const Color(0xFF0F2027),
        surface: Colors.deepPurple,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        brightness: Brightness.dark, // <-- ensure this is set!
      ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amberAccent,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.amberAccent,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontFamily: 'Arcade',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      shadowColor: Colors.amberAccent,
    ),
  ),
);
