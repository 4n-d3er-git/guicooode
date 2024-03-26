import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:search_page/search_page.dart';
import 'package:guicode/cellcom/cellcomListeCodes.dart';
import 'package:url_launcher/url_launcher.dart';

class CELLCOM extends StatefulWidget {
  const CELLCOM({super.key});

  @override
  State<CELLCOM> createState() => _CELLCOMState();
}

class _CELLCOMState extends State<CELLCOM> {
  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;

  void loadInterstitial() {
    InterstitialAd.load(
      
      adUnitId: 
      //test
      "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("InterstitialAd Loaded");
          setState(() {
            interstitialAd = ad;
            isInterstitialAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print("InterstitialAd Failed to Load");
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadInterstitial();
  }
  @override
  Widget build(BuildContext context) {
    final titles = listesCodes.cellcomTitres;
    final subTitles = listesCodes.codesUssdCellcom;
    return Scaffold(
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                //                           <-- widget Card
                child: ListTile(
                  leading: Image.asset('assets/cellcom.jpg'),
                  title: Text(titles[index], style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      subTitles[index],
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  trailing: OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {
                      var telToDial = subTitles[index];
                      telToDial = telToDial.substring(0, telToDial.length - 1);
                      // launchURL("tel:$telToDial" + "%23");
                      FlutterPhoneDirectCaller.callNumber(telToDial + Uri.encodeComponent("#"));
                      print("direct");
                    },
                    child: const Text('Lancer'),
                  ),
                  onTap: () {
                    var telToDial = subTitles[index];
                    telToDial = telToDial.substring(0, telToDial.length - 1);
                    launchURL("tel:$telToDial" + Uri.encodeComponent("#"));
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        elevation: 10,
        tooltip: 'Rchercher',
        onPressed: () {

          if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}

          showSearch(
            context: context,
            delegate: SearchPage(
                onQueryUpdate: print,
                items: ussdetcodecellcom,
                searchLabel: '🔎Rechercher',
                suggestion: const Center(
                  child: Text(
                    '📝Filtrez par Nom ou par Code',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                failure: const Center(
                  child: Text(
                    'Désolé, aucun résultat trouvé 😞.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                filter: (cellcom) => [
                      cellcom.titres,
                      cellcom.codes,
                    ],
                sort: (a, b) => a.compareTo(b),
                builder: (cellcom) => Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Card(
                        //                           <-- widget Card
                        child: ListTile(
                          leading: Image.asset('assets/cellcom.jpg'),
                          title: Text(cellcom.titres, style: TextStyle(fontWeight:  FontWeight.bold)),
                          subtitle: Container(
                            child: Text(
                              cellcom.codes,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 10.0),
                          ),
                          trailing: OutlinedButton(
                            style:
                                OutlinedButton.styleFrom(foregroundColor: Colors.black),
                            onPressed: () {
                              var telToDial = cellcom.codes;
                              telToDial =
                                  telToDial.substring(0, telToDial.length - 1);
                              // launchURL("tel:$telToDial" + "%23");
                              FlutterPhoneDirectCaller.callNumber(telToDial + Uri.encodeComponent("#"));
                      print("direct");
                            },
                            child: const Text('Lancer'),
                          ),
                          onTap: () {
                            var telToDial = cellcom.codes;
                            telToDial =
                                telToDial.substring(0, telToDial.length - 1);
                            launchURL(
                                "tel:$telToDial" + Uri.encodeComponent("#"));
                          },
                        ),
                      ),
                    )),
          );
        },
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

void launchURL(String telToDial) async {
  print(telToDial);
  await canLaunch(telToDial)
      ? await launch(telToDial)
      : throw 'Ne peut pas lancer $telToDial';
}
