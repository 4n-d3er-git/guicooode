import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class APropos extends StatefulWidget {
  const APropos({super.key});

  @override
  State<APropos> createState() => _ProposState();
}

class _ProposState extends State<APropos> {
    String _contenu = "";
  @override
  void initState(){
    super.initState();
    lireAsset();
  }
  Future<void> lireAsset() async{
    String fichierTexte = await rootBundle.loadString('assets/propos.txt');
    setState(() {
      _contenu=fichierTexte;
    
    });
    
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(_contenu)
          ],
        ),
      )
    );
  }
}