import 'package:flutter/material.dart';
import 'package:shop_project/screens/welcome_screen.dart';
import 'package:shop_project/theme/app_theme.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  bool isDark = false; // ThemeMode.system == ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: WelcomeScreen(onThemeToggle: toggleTheme),
    );
  }
}
