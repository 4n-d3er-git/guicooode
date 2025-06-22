import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:guicooode/ad_helper.dart';
import 'package:guicooode/cellcom/cellcom.dart';
import 'package:guicooode/mtn/mtn.dart';
import 'package:guicooode/orange/orange.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  AccueilState createState() {
    return AccueilState();
  }
}

class AccueilState extends State<Accueil> {
  late BannerAd _bannerAd;
  late BannerAd _bannerAd2;
  late BannerAd _bannerAd3;
  late BannerAd _bannerAd4;

  bool _isBannerAdReady = false;
  bool _isBannerAdReady2 = false;
  bool _isBannerAdReady3 = false;
  bool _isBannerAdReady4 = false;

  @override
  void initState() {
    super.initState();
    // chargement de ads.
    log('initiation appelée');
    MobileAds.instance.initialize();
    //banner 1
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          log('Echec de chargement de banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();

    //banner 2
    _bannerAd2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady2 = true;
            log('banner 2 chargé');
          });
        },
        onAdFailedToLoad: (ad, err) {
          log('Echec de chargement de banner ad: ${err.message}');
          _isBannerAdReady2 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd2.load();

    //banner 3
    _bannerAd3 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady3 = true;
            log('banner 3 chargé');
          });
        },
        onAdFailedToLoad: (ad, err) {
          log('Echec de chargement de banner ad: ${err.message}');
          _isBannerAdReady3 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd3.load();

    //banner 4
    _bannerAd4 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady4 = true;
            log('banner 4 chargé');
          });
        },
        onAdFailedToLoad: (ad, err) {
          log('Echec de chargement de banner ad: ${err.message}');
          _isBannerAdReady4 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd4.load();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF2D3748),
            ),
          ),
          // AppBar avec ombre moderne
          shadowColor: Colors.grey.withOpacity(0.1),
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                indicatorColor: Colors.blue.shade600,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                splashBorderRadius: const BorderRadius.all(Radius.circular(50)),
                dividerColor: Colors.transparent,
                labelColor: const Color(0xFF2D3748),
                unselectedLabelColor: Colors.grey.shade600,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),

                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade400,
                                Colors.orange.shade600,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/orange.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 6),
                        const Text('Orange'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.yellow.shade500,
                                Colors.orange.shade500,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/mtn.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 6),
                        const Text('MTN'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.shade400,
                                Colors.pink.shade400,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/cellcom.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 6),
                        const Text('Cellcom'),
                      ],
                    ),
                  ),
                  // Tab(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         width: 30,
                  //         height: 30,
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           gradient: LinearGradient(
                  //             colors: [
                  //               Colors.blue.shade400,
                  //               Colors.blue.shade600,
                  //             ],
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.blue.withOpacity(0.3),
                  //               blurRadius: 8,
                  //               offset: const Offset(0, 3),
                  //             ),
                  //           ],
                  //         ),
                  //         child: const Icon(
                  //           Icons.settings,
                  //           color: Colors.white,
                  //           size: 24,
                  //         ),
                  //       ),
                  //       // const SizedBox(height: 6),
                  //       const Text('Options'),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder<void>(
          future: _initGoogleMobileAds(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return TabBarView(
              children: [
                // Orange Tab
                Container(
                  color: Colors.grey.shade50,
                  child: Column(
                    children: [
                      if (_isBannerAdReady)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: showBannerAds(
                              height: _bannerAd.size.height.toDouble(),
                              width: _bannerAd.size.width.toDouble(),
                              bannerAd: _bannerAd,
                            ),
                          ),
                        ),
                      const Expanded(child: ORANGE()),
                    ],
                  ),
                ),

                // MTN Tab
                Container(
                  color: Colors.grey.shade50,
                  child: Column(
                    children: [
                      if (_isBannerAdReady2)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: showBannerAds(
                              height: _bannerAd2.size.height.toDouble(),
                              width: _bannerAd2.size.width.toDouble(),
                              bannerAd: _bannerAd2,
                            ),
                          ),
                        ),
                      const Expanded(child: MTN()),
                    ],
                  ),
                ),

                // CELLCOM Tab
                Container(
                  color: Colors.grey.shade50,
                  child: Column(
                    children: [
                      if (_isBannerAdReady3)
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: showBannerAds(
                              height: _bannerAd3.size.height.toDouble(),
                              width: _bannerAd3.size.width.toDouble(),
                              bannerAd: _bannerAd3,
                            ),
                          ),
                        ),
                      const Expanded(child: CELLCOM()),
                    ],
                  ),
                ),

                // // Options Tab
                // Container(
                //   color: Colors.grey.shade50,
                //   child: Column(
                //     children: [
                //       if (_isBannerAdReady4)
                //         Container(
                //           margin: const EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.grey.withOpacity(0.1),
                //                 blurRadius: 8,
                //                 offset: const Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(12),
                //             child: showBannerAds(
                //               height: _bannerAd4.size.height.toDouble(),
                //               width: _bannerAd4.size.width.toDouble(),
                //               bannerAd: _bannerAd4,
                //             ),
                //           ),
                //         ),
                //       const Expanded(child: Options()),

                //       // Footer moderne
                //       Container(
                //         margin: const EdgeInsets.all(20),
                //         decoration: BoxDecoration(
                //           gradient: LinearGradient(
                //             colors: [Colors.blue.shade400, Colors.blue.shade600],
                //           ),
                //           borderRadius: BorderRadius.circular(20),
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.blue.withOpacity(0.3),
                //               blurRadius: 15,
                //               offset: const Offset(0, 5),
                //             ),
                //           ],
                //         ),
                //         child: Container(
                //           height: 60,
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Container(
                //                 padding: const EdgeInsets.all(8),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white.withOpacity(0.2),
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child: const Icon(
                //                   Icons.code,
                //                   color: Colors.white,
                //                   size: 24,
                //                 ),
                //               ),
                //               const SizedBox(width: 12),
                //               const Expanded(
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Conçue et Développée par",
                //                       style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w400,
                //                       ),
                //                     ),
                //                     Text(
                //                       "Anderson GOUMOU",
                //                       style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 16,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               Container(
                //                 padding: const EdgeInsets.all(8),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white.withOpacity(0.2),
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child: const Icon(
                //                   Icons.favorite,
                //                   color: Colors.white,
                //                   size: 20,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    //  Initialisaion Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}

class showBannerAds extends StatelessWidget {
  final double width;
  final double height;
  final BannerAd bannerAd;

  const showBannerAds({
    super.key,
    required this.width,
    required this.height,
    required this.bannerAd,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: width,
        height: height,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
