class Orange implements Comparable<Orange> {
  final String titres, codes;

  const Orange(
    this.titres,
    this.codes,
  );

  @override
  int compareTo(Orange other) => titres.compareTo(other.titres);
}

const ussdetcodeorange = [
  Orange(
    "Centre d'appel Distributeurs",
    '8272',
  ),
  Orange(
    "Centre d'appel grand public",
    '8277',
  ),
  Orange(
    'Connaitre Son Numero',
    '*145#',
  ),
  Orange(
    'Information sur le solde',
    '*124#',
  ),
  Orange(
    'Acheter un forfait internet',
    '*222#',
  ),
  Orange(
    'Club SWAG',
    '*707#',
  ),
  Orange(
    'Information sur dernier appel',
    '*223#',
  ),
  Orange(
    'Consulter sa liste de numéros FAF',
    '*125#',
  ),
  Orange(
    'Supprimer un numéro de sa liste FAF',
    '*125*0*Num#',
  ),
  Orange(
    'Ajouter un numéro FAF',
    '*124*1*Num#',
  ),
  Orange(
    'Forfait Choco',
    '*555#',
  ),
  Orange(
    'Acheter un pack SMS',
    '*888#',
  ),
  Orange(
    "Achat de passe jour 200Mo", "*222*1#"),
  Orange("Achat de passe semaine", "*222*2#"),
  Orange("Achat de passe mois", '*222*3#'),
  Orange("Achat de pass TV", '*222*4#'),
  Orange("Consulter le solde", '*222*5#'),
  Orange("Achat pass jour 40Mo", "*222*1*1#"),
  Orange("pass My Friends", '*222*1*2#'),
  Orange("pass 200Mo", "*222*1*3#"),
  Orange("pass 500Mo", '*222*1*4#'),
  Orange("Achat pass Nuit", "*222*1*5#"),
  Orange("Portail éducation", '*222*1*6#'),
  Orange('Achat pass 750Mo', '*222*1*7#'),
  Orange("Passe semaine 1.2Go", "*222*2*1#"),
  Orange("Passe semaine 2.7Go", '*222*2*2#'),
  Orange('Club SWAG Activation', "*707*1#"),
  Orange("Club SWAG pass Internet", '*707*2#'),
  Orange("Club SWAG Pack sms", '*707*3#'),
  Orange("Club SWAG Désactivation", "*707*4#"),
  Orange("Club SWAG Consultation", '*707*5#'),
  Orange("Choco malin 15mn-1500f", '*555*1*1*1#'),
  Orange("Choco malin 15mn-3000f", '*555*1*1*2#'),
  Orange("Choco Magic", '*555*1*2#'),
  Orange("Choco Maxi", "*555*1*3#"),
  Orange("Choco Afrique", '*555*2*1#'),
  Orange("Choco Monde", '*555*2*2#'),
  Orange("Consultation", '*555*3#'),
  Orange("Pack 100sms", '*888*1#'),
  Orange("Pack 50sms", '*888*2#'),
  Orange("Transfert National", '*144*1*1#'),
  Orange("Réception Internationale", '*144*1*2#'),
  Orange("Transfert International", '*144*1*3#'),
  Orange("Solde OM", "*144*3#"),
  Orange("Abonnement Canal+", "*144*4*1*1#"),
  Orange("Abonnement Easy TV", '*144*4*1*2#'),
  Orange("Abonnement Startimes", "*144*4*1*3#"),
  Orange("Code de paiement", "*144*4*2#"),
  Orange("Facture SEG", "*144*4*3*1#"),
  Orange("Facture EDG", "*144*4*3*2#"),
  Orange("Orange Énergie", '*144*4#'),
  Orange("LightBoxAfrica", '*144*5#'),
  Orange("École/Université", '*144*6#'),
  Orange("Service Orange", '*144*7#'),
  Orange("Permis de conduire", "*144*4*8*2#"),
  Orange("Vignette", '*144*4*8*4#'),
//   Orange("Vignette",''),
//   Orange("Vignette",''),
//  Orange("Vignette",''),
//  Orange("Vignette",''),
//  Orange("Vignette",''),
  Orange("Contravention", "*144*4*8*3#"),
  Orange("Impôt", '*144*4*8*1#'),
  Orange("Ubipharm", '*144*4*9#'),
  Orange("Lafarge", '*144*4*10#'),
  Orange("VDC telecom", '*144*4*12*1#'),
  Orange("MouNa Groupe", '*144*4*12*2#'),
  Orange("BIG", '*144*5*1*1*9#'),
  Orange("NSIA", '*144*5*1*1*10#'),
  Orange("SKYE BANK", '*144*5*1*1*11#'),
  Orange("ECOBANK", '*144*5*1*1*1#'),
  Orange("UBA VISA OM", '*144*5*1*1*2#'),
  Orange("Orabank", '*144*5*1*1*3#'),
  Orange("VistaBank", '*144*5*1*1*4#'),
  Orange("Accès Bank", '*144*5*1*1*5#'),
  Orange("Cofina", '*144*5*1*1*6#'),
  Orange("FirstBank", '*144*5*1*1*7#'),
  Orange("BSIC", '*144*5*1*1*8#'),
  Orange("CorisBank", '*144*5*1*1*12#'),
  Orange("Lanala Assurance", '*144*5*2*1#'),
  Orange("NSIA Vie Assurance", '*144*5*2*2#'),
  Orange("SUNU Assurance", '*144*5*2*3#'),
  Orange("Crédit Rural de Guinée", '*144*5*3*1#'),
  Orange("Finadev", '*144*5*3*2#'),
  Orange("PayCard", '*144*5*4*1#'),
  Orange("Paiement Marchand", '*144*6#'),
  Orange("Mon compte OM", '*144*7#'),
  Orange("Changer code OM", '*144*7*1#'),
  Orange("Voir denières operations OM", '*144*7*3#'),
  Orange("Voir les frais d'un rétrait", '*144*7*4*3#'),
  Orange("Débloquer Compte OM", '*144*7*5*1#'),
  Orange("Réinitialiser code OM", '*144*7*5*2#'),
  Orange("Enregistrer un numero de confiance OM", '*144*7*5*3#'),
  Orange("Annuler un Transfert OM", '*144*7*7#'),
  Orange("Guinée Games", '*144*8*1#'),
  Orange("YellowBet", '*144*8*2#'),
  Orange("Orabank", ''),
  Orange("VistaBank", ''),
  Orange("Ouverture de compte", '*144*9#'),
  Orange("Transfert de Crédit", '*126*1*1#'),
  Orange("Transfert de Bonus", '*126*1*2#'),
  Orange("Transfert de Pass", '*126*1*3#'),
  Orange("Transfert de SMS", '*126*1*4#'),
  Orange("Changer code PIN", '*126*2#'),
  Orange("Historique des transferts", '*126*3#'),
  Orange("Récupérer mon code de rechargement", '*126*4#'),
  Orange("Confirmer un retrait", '*146#'),
  Orange("Forfait Haji Arabie Saoudite", "*224#"),
  Orange("Horoscope", '*111*1*1#'),
  Orange("Blague", '*111*1*2#'),
  Orange("RFI", '*111*2*1#'),
  Orange("BBC News", '*111*2*2#'),
  Orange("BBC Sport", '*111*2*3#'),
  Orange("People", '*111*2*4#'),
  Orange("GuinéeNews", '*111*2*5#'),
  Orange("Star Buzz", '*111*2*6#'),
  Orange("Info Gouvernement", '*111*2*7#'),
  Orange("Infos Sport", '*111*2*8#'),
  Orange("Cours de devise", '*111*2*9#'),
  Orange("Guinée 360", '*111*2*10#'),
  Orange("Opportunité", '*111*2*11#'),
  Orange("Agence Guinéenne de Presse", ''),
  Orange("FOOT224", '*111*2*12#'),
  Orange("Sécurité Alerte", ''),
  Orange("Aconakrylive", '*111*2*13#'),
  Orange("Amour et vie", '*111*3*1#'),
  Orange("Conseils de carrière", '*111*3*2#'),
  Orange("Pensée du jour", '*111*3*3#'),
  Orange("Conseils de Femmes", '*111*3*4#'),
  Orange("Proverbes Africains", '*111*3*5#'),
  Orange("Astuces Santé", '*111*3*6#'),
  Orange("Grosses et Maternité", '*111*3*7#'),
  Orange("Culinaires", '*111*3*8#'),
  Orange("Interview", '*111*3*9#'),
  Orange("Stress", '*111*3*11#'),
  Orange("Business", '*111*3*10#'),
  Orange("Heures de Prières", '*111*4*1#'),
  Orange("Hadith", '*111*4*2#'),
  Orange("Versets Bibliques", '*111*4*3#'),
  Orange("English lesson", '*111*5*2#'),
  Orange("Conjugaison", '*111*5*1#'),
  Orange("Fonction Publique", '*111*6*1#'),
  Orange("BTP et Industrie", '*111*6*2#'),
  Orange("Finance et Administration", '*111*6*3#'),
  Orange("Informatique et Télécom", '*111*6*4#'),
  Orange("Santé et Services", '*111*6*5#'),
  Orange("Tous secteurs", '*111*6*6#'),
  Orange("Développement Personnel", '*111*7*1#'),
  Orange("Citations de grands Hommes", '*111*7*2#'),
  Orange("Location", '*111*8*1#'),
  Orange("Vente", '*111*8*2#'),
  Orange("PlayCiné", ''),
  Orange("YouScrib", ''),
  Orange("Activer SOS crédit", '*200#'),
];

class listesCodes implements Comparable<listesCodes> {
  final String ussd, code;

  listesCodes(
    this.ussd,
    this.code,
  );

  @override
  int compareTo(listesCodes other) => ussd.compareTo(other.code);
  static final orangeTitres = [
    'Centre d\'appel Distributeurs',
    'Centre d\'appel grand public',
    'Conaitre son numero',
    'Information sur le solde',
    'Acheter un forfait internet',
    // 'Rappelle moi'
    'Club SWAG',
    'Information sur dernier appel',
    'Consulter sa liste de numéros FAF',
    'Supprimer un numéro de sa liste FAF',
    'Ajouter un numéro FAF',
    'Forfait Choco',
    'Acheter un pack SMS',
  ];

  static final codesUssdOrange = [
    '8272',
    '8277',
    '*145#',
    '*124#',
    '*222#',
    // '*120#',
    '*707#',
    '*223#',
    '*125#',
    '*125*0*Num#',
    '*125*1*Num#',
    '*555#',
    '*888#',
  ];
}
