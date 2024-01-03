import 'package:flutter/material.dart';
import 'package:guicode/options/qui_suis_je.dart';
import 'package:guicode/options/apropos.dart';


class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.perm_device_information),
            title: const Text("A Propos"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const APropos()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.ios_share),
            title: const Text("Partager l'Application"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.question_mark),
            title: const Text("Qui suis-je ?"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Qui_Suis_Je()),
              );
            },
          ),
        ],
      ),
    );
  }
}
