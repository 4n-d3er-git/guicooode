import 'package:flutter/material.dart';
import 'package:guicode/splash_screen.dart';

  
void main() {
  runApp(GuiCode());
}

class GuiCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: MaterialApp(
        title: 'Guicode',
        theme: ThemeData(
         tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.black,
          labelColor: Colors.black
         )
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
