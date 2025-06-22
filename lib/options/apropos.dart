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
  void initState() {
    super.initState();
    lireAsset();
  }

  Future<void> lireAsset() async {
    String fichierTexte = await rootBundle.loadString('assets/propos.txt');
    setState(() {
      _contenu = fichierTexte;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A propos')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [Text(_contenu)]),
      ),
    );
  }
}
