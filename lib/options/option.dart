import 'package:flutter/material.dart';
import 'package:guicode/options/qui_suis_je.dart';
import 'package:guicode/options/apropos.dart';
import 'package:guicode/partager.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter/cupertino.dart';


class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.info),
            title: const Text("A Propos"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const APropos()),
              );
            },
          ),
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.share),
            title: const Text("Partager l'application"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              share();
            },
          ),
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.star_circle),
            title: const Text("Noter l'application"),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => RatingDialog(
                              initialRating: 4.0,
                              // your app's name?
                              title: const Text(
                                'GuiCode',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // encourage your user to leave a high rating?
                              message: const Text(
                                "Appuyez sur  l'étoile pour définir votre note.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                              // your app's logo?
                              // image: Image.asset("assets/guilo.png"),
                              submitButtonText: 'Noter',

                              commentHint: 'Ajoutez votre avis ici',
                              onCancelled: () => print('cancelled'),
                              onSubmitted: (response) async {
                                print(
                                    'rating: ${response.rating}, comment: ${response.comment}');

                                // TODO: add your own logic
                                if (response.rating < 3.0) {
                                  // send their comments to your email or anywhere you wish
                                  // ask the user to contact you instead of leaving a bad review
                                } else {
                                  final _inAppReview = InAppReview.instance;

                                  if (await _inAppReview.isAvailable()) {
                                    print('request actual review from store');
                                    _inAppReview.requestReview();
                                  } else {
                                    print('open actual store listing');
                                    // TODO: use your own store ids
                                    _inAppReview.openStoreListing(
                                      appStoreId: '5172574618966502885',
                                      // '<your app store id>',
                                      microsoftStoreId:
                                          '<your microsoft store id>',
                                    );
                                  }
                                }
                              },
                            ));
            },
          ),
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.question),
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
