import 'package:flutter_share/flutter_share.dart';


Future<void> share() async {
    await FlutterShare.share(
        title: 'Partager',
        text: 'Téléchargez GuiCode et gagnez du temps en trouvant instantanément les codes Orange, MTN et Celcom dont vous avez besoin !.',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.guicode',
        chooserTitle: "Téléchargez GuiCode maintenant sur Play Store !"
        );
  }