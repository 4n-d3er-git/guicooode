// import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Qui_Suis_Je extends StatefulWidget {
//   const Qui_Suis_Je({super.key});

//   @override
//   State<Qui_Suis_Je> createState() => _ProposState();
// }

// class _ProposState extends State<Qui_Suis_Je> {
//     String _contenu = "";
//   @override
//   void initState(){
//     super.initState();
//     lireAsset();
//   }
//   Future<void> lireAsset() async{
//     String fichierTexte = await rootBundle.loadString('assets/quisuisje.txt');
//     setState(() {
//       _contenu=fichierTexte;

//     });

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Padding(
//         padding: EdgeInsets.all(20),
//         child: ListView(
//           children: [
//             Text(_contenu)
//           ],
//         ),
//       )
//     );
//   }
// }

import 'package:contactus/contactus.dart';

class Qui_Suis_Je extends StatelessWidget {
  const Qui_Suis_Je({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Anderson Goumou',
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        email: 'andersongoumou10@gmail.com',
        // textFont: 'Sail',
      ),
      backgroundColor: Colors.blue,
      body: ContactUs(
        cardColor: Colors.white,
        textColor: Colors.black,
        logo: const AssetImage('assets/ander0.jpg'),
        email: 'andersongoumou10@gmail.com',
        companyName: 'Anderson',
        companyColor: Colors.black54,
        dividerThickness: 2,
        phoneNumber: '+224620878831',
        website: 'https://andersongoumou.000webhostapp.com',
        githubUserName: '4n-d3er-git',
        linkedinURL: 'https://www.linkedin.com/in/anderson-g-164802264/',
        tagLine: '',
        taglineColor: Colors.teal.shade100,
        twitterHandle: 'GoumouAnderson',
        instagram: 'an_der_s0n_',
        facebookHandle: 'Anderson.goumou',
      ),
    );
  }
}
