import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const seed = Color(0xFF1E3A5F);
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seed),
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
