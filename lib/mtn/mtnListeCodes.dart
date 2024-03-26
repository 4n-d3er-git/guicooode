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
  Mtn(
    "Vérifier son Enregistrement",
    '*112#',
  ),
  Mtn("Info Code PUK", '*112*3#'),
  Mtn("Demande de modification", '*112*2#'),
  Mtn("Vérifier son Identité GSM et MoMo", ''),
  Mtn("Numéro Favoris", ''),
  Mtn("S'auto enregistrer MoMo", ''),
  Mtn("Consulter solde SMS", '*223#'),
  Mtn("Partager des crédits", '*102#'),
  Mtn(
    "Emprunt crédits ou internet",
    '*200#',
  ),
  Mtn(
    "Service à valeur ajoutée",
    '*444#',
  ),
  Mtn(
    "Désactiver",
    '*411#',
  ),
  Mtn(
    "Consulter solde Internet",
    '*223*20#',
  ),
  Mtn("Service Mobile Money", '*440#'),
  Mtn("Historique des transactions", '*311#'),
  Mtn("Centre d'appel prépayé", '8800'),
  Mtn("Centre d'appel Distributeur", "8555"),
  Mtn("Centre d'appel post payé", "8777"),
  Mtn("Infos Service Client 111", '*111#'),
  Mtn("Forfait Spécial", "*160#"),
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
    //!ici
    "Vérifier son Enregistrement",
    "Info Code PUK",
    "Demande de modification",
    "Vérifier son Identité GSM et MoMo",
    "Numéro Favoris",
    "S'auto enregistrer MoMo",
    "Consulter solde SMS",
    "Partager des crédits",
    "Emprunt crédits ou internet",
    "Service à valeur ajoutée",
    "Désactiver",
    "Consulter solde Internet",
    "Service Mobile Money",
    "Historique des transactions",
    "Centre d'appel prépayé",
    "Centre d'appel Distributeur",
    "Centre d'appel post payé",
    "Infos Service Client 111",
    "Forfait Spécial",
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
    '*112#',
    '*112*3#',
    '*112*2#',
    '',
    '',
    '',
    '*223#',
    '*102#',
    '*200#',
    '*444#',
    '*411#',
    '*223*20#',
    '*440#',
    '*311#',
    '8800',
    "8555",
    "8777",
    '*111#',
    "*160#",
  ];
}
