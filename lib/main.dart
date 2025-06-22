import 'package:flutter/material.dart';
import 'package:guicooode/splash_screen.dart';

void main() {
  runApp(const GuiCode());
}

class GuiCode extends StatelessWidget {
  const GuiCode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guicode',
      theme: ThemeData(
        tabBarTheme: const TabBarThemeData(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
