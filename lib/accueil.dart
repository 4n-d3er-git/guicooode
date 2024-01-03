import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:guicode/ad_helper.dart';
import 'package:guicode/cellcom/cellcom.dart';
import 'package:guicode/mtn/mtn.dart';
import 'package:guicode/options/option.dart';
import 'package:guicode/orange/orange.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<Accueil> {
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
    print('initiation appelée');
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
          print('Echec de chargement de banner ad: ${err.message}');
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
            print('banner 2 chargé');
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Echec de chargement de banner ad: ${err.message}');
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
            print('banner 3 chargé');
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Echec de chargement de banner ad: ${err.message}');
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
            print('banner 4 chargé');
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Echec de chargement de banner ad: ${err.message}');
          _isBannerAdReady4 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd4.load();
  }

  @override
  Widget build(BuildContext context) {
    print('build appelée');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: const TabBar(
          tabs: [
            Tab(
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: ExactAssetImage('assets/orange.png'),
                backgroundColor: Colors.orange,
              ),
              text: 'Orange',
            ),
            Tab(
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: ExactAssetImage('assets/mtn.png'),
                backgroundColor: Colors.yellow,
              ),
              text: 'MTN',
            ),
            Tab(
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: ExactAssetImage('assets/cellcom.jpg'),
              ),
              text: 'Celcom',
            ),
            Tab(
              icon: CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
              ),
              text: 'Options',
            )
          ],
        ),
      ),
      body: FutureBuilder<void>(
          future: _initGoogleMobileAds(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return TabBarView(
              children: [
                Center(
                  child: Column(
                    children: [
                      if (_isBannerAdReady)
                        showBannerAds(
                            height: _bannerAd.size.height.toDouble(),
                            width: _bannerAd.size.width.toDouble(),
                            bannerAd: _bannerAd),
                      const Expanded(child: ORANGE()),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      if (_isBannerAdReady2)
                        showBannerAds(
                            height: _bannerAd2.size.height.toDouble(),
                            width: _bannerAd2.size.width.toDouble(),
                            bannerAd: _bannerAd2),
                      const Expanded(child: MTN()),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      if (_isBannerAdReady3)
                        showBannerAds(
                            height: _bannerAd3.size.height.toDouble(),
                            width: _bannerAd3.size.width.toDouble(),
                            bannerAd: _bannerAd3),
                      const Expanded(child: CELLCOM())
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      if (_isBannerAdReady4)
                        showBannerAds(
                            height: _bannerAd4.size.height.toDouble(),
                            width: _bannerAd4.size.width.toDouble(),
                            bannerAd: _bannerAd4),
                      const Expanded(child: Options()),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        child: const Center(
                            child: const Text.rich(TextSpan(
                                text: "Conçue et Développée par",
                                style: TextStyle(color: Colors.white),
                                children: [
                              TextSpan(
                                  text: " Anderson GOUMOU",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ]))),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
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

  const showBannerAds(
      {Key? key,
      required this.width,
      required this.height,
      required this.bannerAd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: width,
        height: height,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}

