import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String? note;
  final Timestamp? timestamp;

  Buyers({
    required this.buyerName,
    required this.Poultry,
    required this.contactNum,
    required this.address,
    required this.date,
    required this.numofTray,
    required this.unitPrice,
    required this.buyerId,
    required this.timestamp,
    this.imageUrl = "",
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
      'note': note,
      'timestamp': timestamp
    };
  }

  Buyers.fromFirestore(Map<String, dynamic>? firestore)
      : buyerName = firestore?['buyerName'],
        Poultry = firestore?['Poultry'],
        contactNum = firestore?['contactNum'],
        address = firestore?['address'],
        date = firestore?['date'],
        numofTray = firestore?['numofTray'],
        unitPrice = firestore?['unitPrice'],
        buyerId = firestore?['buyerId'],
        imageUrl = firestore?['imageUrl'],
        timestamp = firestore?['timestamp'],
        note = firestore?['note'];
}
