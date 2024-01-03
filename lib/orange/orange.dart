import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:guicode/orange/orangeListeCodes.dart';
import 'package:url_launcher/url_launcher.dart';


class ORANGE extends StatelessWidget {
  const ORANGE({super.key});

  @override
  Widget build(BuildContext context) {
final titles = listesCodes.orangeTitres;
    final subTitles = listesCodes.codesUssdOrange;
    return Scaffold(
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                child: ListTile(
                  leading: Image.asset('assets/orange.png'),
                  title: Text(titles[index]),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      subTitles[index],
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  trailing: OutlinedButton(
                    style: OutlinedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      var telToDial = subTitles[index];
                      telToDial = telToDial.substring(0, telToDial.length - 1);
                      launchURL("tel:$telToDial" + "%23");
                    },
                    child: const Text('Composer'),
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
        backgroundColor: Colors.orange[800],
        elevation: 10,
        tooltip: 'Rchercher',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage(
            onQueryUpdate: print,
            items: ussdetcodeorange,
            searchLabel: '🔎Rechercher',
            suggestion: const Center(
              child: Text('📝Filtrez par Nom ou par Code', style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
            failure: const Center(
              child: Text('Désolé, aucun résultat trouvé 😞.',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
            filter: (orange) => [
              orange.titres,
              orange.codes,
            ],
            sort: (a, b) => a.compareTo(b),
            builder: (orange) => Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                child: ListTile(
                  leading: Image.asset('assets/orange.png'),
                  title: Text(orange.titres),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      orange.codes,
                      style: TextStyle(
                        color: Colors.yellow[800],
                        fontSize: 18,
                      ),
                    ),
                  ),
                  trailing: OutlinedButton(
                    style: OutlinedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      var telToDial = orange.codes;
                      telToDial = telToDial.substring(0, telToDial.length - 1);
                      launchURL("tel:$telToDial" + "%23");
                    },
                    child: const Text('Composer'),
                  ),
                  onTap: () {
                    var telToDial = orange.codes;
                    telToDial = telToDial.substring(0, telToDial.length - 1);
                    launchURL("tel:$telToDial" + Uri.encodeComponent("#"));
                  },
                ),
              ),
              
            )
            ),
          ),
        
        child: const Icon(Icons.search, color: Colors.white,),

          ),
    );
  }
}

void launchURL(String telToDial) async {
  print(telToDial);
  await canLaunch(telToDial)
      ? await launch(telToDial)
      : throw 'Ne peux pas lancer $telToDial';
}