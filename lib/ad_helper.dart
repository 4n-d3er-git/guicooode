import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // vous pouvez le remplacer par le votre
      return 'ca-app-pub-3940256099942544/6300978111'; //test
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; //test
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
