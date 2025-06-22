import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
// class ItemsCard extends StatelessWidget {
//   final String titre;
//   final String image;
//   final String subTitle;
//   const ItemsCard({
//     super.key,
//     required this.titre,
//     required this.image,
//     required this.subTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//       child: ListTile(
//         leading: Image.asset(image),
//         title: Text(titre, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Container(
//           margin: const EdgeInsets.only(top: 10.0),
//           child: Text(
//             subTitle,
//             style: const TextStyle(color: Colors.red, fontSize: 18),
//           ),
//         ),
//         trailing: OutlinedButton(
//           style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
//           onPressed: () {
//             var telToDial = subTitle;
//             telToDial = telToDial.substring(0, telToDial.length - 1);
//             // launchURL("tel:$telToDial" + "%23");
//             FlutterPhoneDirectCaller.callNumber(
//               telToDial + Uri.encodeComponent("#"),
//             );
//             log("direct");
//           },
//           child: const Text('Lancer'),
//         ),
//         onTap: () {
//           var telToDial = subTitle;
//           telToDial = telToDial.substring(0, telToDial.length - 1);
//           launchURL("tel:$telToDial${Uri.encodeComponent("#")}");
//         },
//       ),
//     );
//   }
// }
class ItemsCard extends StatelessWidget {
  final String titre;
  final String image;
  final String subTitle;
  final Color color1;
  final Color color2;
  final Color color3;
  const ItemsCard({
    super.key,
    required this.titre,
    required this.image,
    required this.subTitle,
    required this.color1,
    required this.color2,
    required this.color3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            var telToDial = subTitle;
            telToDial = telToDial.substring(0, telToDial.length - 1);
            launchURL("tel:$telToDial${Uri.encodeComponent("#")}");
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.8),
                        Colors.pink.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(image, width: 24, height: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color1,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: color2, width: 1),
                        ),
                        child: Text(
                          subTitle,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color3,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    var telToDial = subTitle;
                    telToDial = telToDial.substring(0, telToDial.length - 1);
                    FlutterPhoneDirectCaller.callNumber(
                      telToDial + Uri.encodeComponent("#"),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.call, size: 19, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void launchURL(String telToDial) async {
  log(telToDial);
  await canLaunch(telToDial)
      ? await launch(telToDial)
      : throw 'Ne peut pas lancer $telToDial';
}
