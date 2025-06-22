import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:guicooode/guicode_ai/guicode_ai.dart';
import 'package:guicooode/options/option.dart';
import 'package:guicooode/widgets/items_card_widget.dart';
import 'package:search_page/search_page.dart';
import 'package:guicooode/cellcom/cellcomListeCodes.dart';

// class CELLCOM extends StatefulWidget {
//   const CELLCOM({super.key});

//   @override
//   State<CELLCOM> createState() => _CELLCOMState();
// }

// class _CELLCOMState extends State<CELLCOM> {
//   InterstitialAd? interstitialAd;
//   bool isInterstitialAdLoaded = false;

//   void loadInterstitial() {
//     InterstitialAd.load(
//       adUnitId:
//           //test
//           "ca-app-pub-3940256099942544/1033173712",
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) {
//           log("InterstitialAd Loaded");
//           setState(() {
//             interstitialAd = ad;
//             isInterstitialAdLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (error) {
//           log("InterstitialAd Failed to Load");
//         },
//       ),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     loadInterstitial();
//   }

//   final _key = GlobalKey<ExpandableFabState>();

//   @override
//   Widget build(BuildContext context) {
//     final titles = listesCodes.cellcomTitres;
//     final subTitles = listesCodes.codesUssdCellcom;
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: titles.length,
//         itemBuilder: (context, index) {
//           return ItemsCard(
//             titre: titles[index],
//             image: "assets/cellcom.jpg",
//             subTitle: subTitles[index],
//           );
//         },
//       ),
//       floatingActionButtonLocation: ExpandableFab.location,

//       floatingActionButton: ExpandableFab(
//         key: _key,
//         elevation: 10,
//         type: ExpandableFabType.fan,
//         childrenAnimation: ExpandableFabAnimation.rotate,
//         distance: 130,
//         overlayStyle: ExpandableFabOverlayStyle(
//           color: Colors.black.withOpacity(0.3),
//           blur: 5,
//         ),
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Options',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 20),
//               FloatingActionButton(
//                 backgroundColor: Colors.white,
//                 heroTag: null,
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Options()),
//                   );
//                 },
//                 child: Icon(Icons.info, color: Colors.red[800]),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               const Text(
//                 'Guicod AI',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               FloatingActionButton(
//                 backgroundColor: Colors.white,
//                 heroTag: null,
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => GuicodeAiHomeScreen2(),
//                     ),
//                   );
//                 },
//                 child: Icon(Icons.question_answer, color: Colors.red[800]),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 'Rechercher',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 20),
//               FloatingActionButton(
//                 backgroundColor: Colors.white,
//                 heroTag: null,
//                 onPressed: () {
//                   if (isInterstitialAdLoaded) {
//                     interstitialAd!.show();
//                   }

//                   showSearch(
//                     context: context,
//                     delegate: SearchPage(
//                       onQueryUpdate: print,
//                       items: ussdetcodecellcom,
//                       searchLabel: '🔎Rechercher',
//                       suggestion: const Center(
//                         child: Text(
//                           '📝Filtrez par Nom ou par Code',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       failure: const Center(
//                         child: Text(
//                           'Désolé, aucun résultat trouvé 😞.',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       filter: (cellcom) => [cellcom.titres, cellcom.codes],
//                       sort: (a, b) => a.compareTo(b),
//                       builder:
//                           (cellcom) => ItemsCard(
//                             titre: cellcom.titres,
//                             image: "assets/cellcom.jpg",
//                             subTitle: cellcom.codes,
//                           ),
//                     ),
//                   );
//                 },
//                 child: Icon(Icons.search, color: Colors.red[800]),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class CELLCOM extends StatefulWidget {
  const CELLCOM({super.key});

  @override
  State<CELLCOM> createState() => _CELLCOMState();
}

class _CELLCOMState extends State<CELLCOM> with TickerProviderStateMixin {
  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;
  bool _isFabExpanded = false;

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;
  late AnimationController _listController;
  late Animation<double> _listAnimation;

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          log("InterstitialAd Loaded");
          setState(() {
            interstitialAd = ad;
            isInterstitialAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          log("InterstitialAd Failed to Load");
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Animation pour le FAB
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeInOut,
    );

    // Animation pour la liste
    _listController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _listAnimation = CurvedAnimation(
      parent: _listController,
      curve: Curves.easeOutBack,
    );

    // Démarrer l'animation de la liste
    _listController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInterstitial();
  }

  @override
  void dispose() {
    _fabController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabExpanded = !_isFabExpanded;
    });

    if (_isFabExpanded) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
  }

  Widget _buildFloatingActionMenu() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Overlay avec animation
        if (_isFabExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleFab,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.black.withOpacity(0.5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ),
          ),

        // Menu Items avec animations
        AnimatedBuilder(
          animation: _fabAnimation,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Options
                Transform.translate(
                  offset: Offset(0, -25 * _fabAnimation.value),
                  child: Transform.scale(
                    scale: _fabAnimation.value,
                    child: Opacity(
                      opacity: _fabAnimation.value,
                      child: _buildFabMenuItem(
                        label: 'Options',
                        icon: Icons.settings,
                        gradient: [Colors.red.shade400, Colors.pink.shade400],
                        onTap: () {
                          _toggleFab();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Options(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // GuiCode AI
                Transform.translate(
                  offset: Offset(0, -20 * _fabAnimation.value),
                  child: Transform.scale(
                    scale: _fabAnimation.value,
                    child: Opacity(
                      opacity: _fabAnimation.value,
                      child: _buildFabMenuItem(
                        label: 'GuiCode AI',
                        icon: Icons.psychology,
                        gradient: [
                          Colors.purple.shade400,
                          Colors.blue.shade400,
                        ],
                        onTap: () {
                          _toggleFab();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuicodeAiHomeScreen2(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Search
                Transform.translate(
                  offset: Offset(0, -15 * _fabAnimation.value),
                  child: Transform.scale(
                    scale: _fabAnimation.value,
                    child: Opacity(
                      opacity: _fabAnimation.value,
                      child: _buildFabMenuItem(
                        label: 'Rechercher',
                        icon: Icons.search,
                        gradient: [Colors.green.shade400, Colors.teal.shade400],
                        onTap: () {
                          _toggleFab();
                          if (isInterstitialAdLoaded) {
                            interstitialAd!.show();
                          }
                          _showModernSearch();
                        },
                      ),
                    ),
                  ),
                ),

                // Main FAB avec animation de rotation
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      colors:
                          _isFabExpanded
                              ? [Colors.pink.shade400, Colors.red.shade600]
                              : [Colors.red.shade400, Colors.red.shade600],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isFabExpanded ? Colors.pink : Colors.red)
                            .withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    onPressed: _toggleFab,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _isFabExpanded ? 0.125 : 0.0,
                      child: Icon(
                        _isFabExpanded ? Icons.close : Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFabMenuItem({
    required String label,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(colors: gradient),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            heroTag: label,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  void _showModernSearch() {
    showSearch(
      context: context,
      delegate: SearchPage(
        onQueryUpdate: print,
        items: ussdetcodecellcom,
        searchLabel: '🔎 Rechercher un code USSD',
        suggestion: Container(
          width: double.infinity,

          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.1),
                      Colors.pink.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.search, size: 60, color: Colors.red),
              ),
              const SizedBox(height: 20),
              const Text(
                '📝 Filtrez par Nom ou par Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Commencez à taper pour rechercher',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        failure: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.search_off,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Désolé, aucun résultat trouvé 😞',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Essayez avec des mots-clés différents',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        filter: (cellcom) => [cellcom.titres, cellcom.codes],
        sort: (a, b) => a.compareTo(b),
        builder:
            (cellcom) => ItemsCard(
              titre: cellcom.titres,
              image: 'assets/cellcom.jpg',
              subTitle: cellcom.codes,
              color1: Colors.red.shade50,
              color2: Colors.red.shade200,
              color3: Colors.red.shade700,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titles = listesCodes.cellcomTitres;
    final subTitles = listesCodes.codesUssdCellcom;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100, top: 10),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _listAnimation,
            builder: (context, child) {
              // Animation échelonnée pour chaque élément
              final delay = index * 0.1;
              final animationValue = Curves.easeOutBack.transform(
                (_listAnimation.value - delay).clamp(0.0, 1.0),
              );

              return Transform.translate(
                offset: Offset(0, 30 * (1 - animationValue)),
                child: Opacity(
                  opacity: animationValue.clamp(0.0, 1.0),
                  child: ItemsCard(
                    titre: titles[index],
                    image: 'assets/cellcom.jpg',
                    subTitle: subTitles[index],
                    color1: Colors.red.shade50,
                    color2: Colors.red.shade200,
                    color3: Colors.red.shade700,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingActionMenu(),
    );
  }
}
