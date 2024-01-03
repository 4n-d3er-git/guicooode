class Cellcom implements Comparable<Cellcom> {
  final String titres, codes;

  const Cellcom(this.titres, this.codes,);

  @override
  int compareTo(Cellcom other) => titres.compareTo(other.titres);
}

 const ussdetcodecellcom = [
    Cellcom('Anderson Goumou', '', ),
    Cellcom('Information sur le solde', '*223#', ),
    Cellcom('Acheter un forfait Internet', '700', ),
    
  ];

  class listesCodes  implements Comparable<listesCodes>{
   
  final String ussd, code;

   listesCodes(this.ussd, this.code,);

  @override
  int compareTo(listesCodes other) => ussd.compareTo(other.code);
  static final cellcomTitres = [
    'Information sur le solde',
    'Acheter un forfait internet',
  ];

  static final codesUssdCellcom = [
    '*223#',
    '*7OO#',
    
    
  ];
  }