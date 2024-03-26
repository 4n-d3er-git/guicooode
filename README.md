
# GuiCode

Une application dans laquelle vous trouverez à peu près tous les codes ussd de Orange, MTN et Celcom en Guinée Conakry

[![Logo](https://github.com/4n-d3er-git/guicooode/blob/main/assets/logodeplaystore.png](https://play.google.com/store/apps/details?id=com.guicode)

## Screenshots

![App Screenshot](https://github.com/4n-d3er-git/guicooode/blob/main/assets/guicode.jpg)


## Fonctonnalités

- Voir la liste des codes par réseau
- Rechercher par par nom ou par code
- Lancer le code directement dans le téléphone
- Les annonces avec Google Mobile Ads

## Tehnologies Utilisées

**Client:** Dart, Fluter, Google Mobile Ads

## Lancer l'application localement

Cloner le projet

```dart
  git clone https://github.com/4n-d3er-git/guicooode.git
```

Accéder au Répertoire du Projet :

```bash
  cd chemin/vers/lerepo
```

Installer les Dépendances Flutter
- Assurez-vous d'avoir Flutter installé correctement en suivant les instructions sur [le site officiel de Flutter.](https://flutter.dev/)
- Une fois Flutter installé, ouvrez le terminal et Assurez-vous d'être dans le répertoire du projet (si ce n'est pas déjà le cas).
- Exécutez la commande suivante pour obtenir toutes les dépendances spécifiées dans le fichier pubspec.yaml :

```bash
  flutter pub get
```

Exécuter l'Application

- Connectez votre appareil ou lancez un émulateur.
- Exécutez la commande

```bash
  flutter run

```


## FAQ

#### Comment changer le nom de l'application ?

Rendez-vous dans
```dart
  android/app/src/main/AndroidManifest.xml
```
et modifiez uniquement la valeur de **android:label**
situé dans la balise **application**.

#### Comment Changer l'icon de l'application ?

Rendez-vous dans le fichier ```pusbspec.yaml``` puis changez la valeur de ```image_path``` dans ```flutter_launcher_icons``` ou suivez les instructions [ici](https://pub.dev/packages/flutter_launcher_icons).

#### Comment changer le splash screen ?

Rendez-vous dans le fichier ```pusbspec.yaml``` puis changez la valeur de ```image``` dans ```flutter_native_splash``` ou suivez les instructions [ici](https://pub.dev/packages/flutter_native_splash).

#### Comment configurer Goolgle Mobile Ads ?
- [Créez un compte AdMob](https://support.google.com/admob/answer/7356219?hl=fr&visit_id=638398853939136486-548754844&rd=1#step1).
- Puis [enrégistrez l'application](https://support.google.com/admob/answer/9989980?hl=fr&visit_id=638398853941631042-2834540773&rd=1)
- Ensuite [suivez ces instructions](https://developers.google.com/admob/flutter/quick-start?hl=fr#platform_specific_setup)
Notez bien: vous devez juste remplacer l'Id de l'application dans ```android/app/src/main/AndroidManifest.xml``` et en fin l'id de l'annonce dans le fichier ```ad_helper.dart```. banner ad uniquement.

## License

[MIT](https://github.com/4n-d3er-git/guicooode/tree/main?tab=MIT-1-ov-file#)


## Commentaires

Si vous avez des commentaires, n’hésitez pas à me contacter à l’adresse andersongoumou10@gmail.com


## 🚀 A propos de moi
[Anderson GOUMOU](https://github.com/4n-d3er-git/Anderson-Goumou-#)

