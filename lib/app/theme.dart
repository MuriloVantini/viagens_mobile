import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const seed = Color(0xFF1B3C59);
  const surface = Color(0xFFF4F1EC);
  return ThemeData(
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        foregroundColor: Colors.white,
        backgroundColor: seed,
        minimumSize: const Size(100, 48),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: seed, surface: surface),
    useMaterial3: true,
    scaffoldBackgroundColor: surface,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Color(0xFF102A3B),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF102A3B),
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
