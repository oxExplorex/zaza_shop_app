import 'package:flutter/material.dart';

class AppTheme {
  // светлая
  static ThemeData get light => _buildTheme(Brightness.light);

  // темна
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,

      brightness: brightness,

      fontFamily: "Roboto",
    );
  }
}
