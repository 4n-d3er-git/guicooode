class Mtn implements Comparable<Mtn> {
  final String titres, codes;

  const Mtn(
    this.titres,
    this.codes,
  );

  @override
  int compareTo(Mtn other) => titres.compareTo(other.titres);
}

const ussdetcodemtn = [
  Mtn(
    'Connaitre Son Numero',
    '*223#',
  ),
  Mtn(
    'Information su le solde',
    '*223#',
  ),
  Mtn(
    'MTN ComJAIM',
    '*100*1#',
  ),
  Mtn(
    'MTN Wakhati',
    '*100*2#',
  ),
  Mtn(
    'Acheter un forfait Internet',
    '*100*3#',
  ),
  Mtn(
    'Appels Internationaux',
    '*100*4#',
  ),
  Mtn(
    'MTN Cool+',
    '*100*5#',
  ),
  Mtn(
    'MTN KDO',
    '*100*6#',
  ),
  Mtn(
    'Forfaits SMS',
    '*100*7#',
  ),
  Mtn(
    'Connaitre Son Numero',
    '*223#',
  ),
  Mtn("Vérifier son Enregistrement",'*112#'),
  Mtn("Info Code PUK",''),
  Mtn("Demande de modification",''),
  Mtn("Vérifier son Identité GSM et MoMo",''),
  Mtn("Numéro Favoris",''),
  Mtn("S'auto enregistrer MoMo",''),
  Mtn("Consulter solde SMS",''),
  Mtn("Partager des crédits",''),
  Mtn("Emprunt crédits ou internet",'*200#'),
  Mtn("Service à valeur ajoutée",'*444#'),
  Mtn("Désactiver",'*411#'),
  Mtn("Consulter solde Internet",'*223*20#'),
  Mtn("Service Mobile Money",''),
  Mtn("Historique des transactions",''),
  Mtn("Centre d'appel prépayé",''),
  Mtn("Centre d'appel Distributeur",""),
  Mtn("Centre d'appel post payé",""),
  Mtn("Infos Service Client 111",''),
  
];

class listesCodes implements Comparable<listesCodes> {
  final String ussd, code;

  listesCodes(
    this.ussd,
    this.code,
  );

  @override
  int compareTo(listesCodes other) => ussd.compareTo(other.code);
  static final mtnTitres = [
    'Conaitre son numero',
    'Information sur le solde',
    'MTN ComJAIM',
    "MTN Wakhati",
    'Acheter un forfait internet',
    'Appels Internationaux',
    "MTN Cool+",
    "MTN KDO",
    "Forfaits SMS",
  ];

  static final codesUssdMtn = [
    '*223#',
    '*223#',
    '*100*1#',
    '*100*2#',
    '*100*3#',
    '*100*4#',
    '*100*5#',
    '*100*6#',
    '*100*7#',
  ];
}
