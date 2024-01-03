import 'package:flutter/material.dart';
import 'package:guicode/accueil.dart';

  
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
        home: Accueil(title: '*GuiCode#',),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
