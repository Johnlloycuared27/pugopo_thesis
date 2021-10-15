class Buyers {
  final String? buyerName;
  final String? Poultry;
  final int? contactNum;
  final String? address;
  final String? date;
  final int? numofTray;
  final double? unitPrice;
  final String? buyerId;
  final String? imageUrl;
  final bool? approved;
  final String? note;

  Buyers({
    required this.buyerName,
    required this.Poultry,
    required this.contactNum,
    required this.address,
    required this.date,
    required this.numofTray,
    required this.unitPrice,
    required this.buyerId,
    this.imageUrl = "",
    required this.approved,
    this.note = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'buyerName': buyerName,
      'Poultry': Poultry,
      'contactNum': contactNum,
      'address': address,
      'date': date,
      'numofTray': numofTray,
      'unitPrice': unitPrice,
      'buyerId': buyerId,
      'imageUrl': imageUrl,
      'approved': approved,
      'note': note,
    };
  }

  Buyers.fromFirestore(Map<String, dynamic> firestore)
      : buyerName = firestore['buyerName'],
        Poultry = firestore['Poultry'],
        contactNum = firestore['contactNum'],
        address = firestore['address'],
        date = firestore['date'],
        numofTray = firestore['numofTray'],
        unitPrice = firestore['unitPrice'],
        buyerId = firestore['buyerId'],
        imageUrl = firestore['imageUrl'],
        approved = firestore['approved'],
        note = firestore['note'];
}
