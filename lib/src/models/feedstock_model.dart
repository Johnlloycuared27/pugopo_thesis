import 'package:cloud_firestore/cloud_firestore.dart';

class FeedStockModel {
  final String? date;
  final int? numberfeedStock;
  final String? feedstockId;
  final Timestamp? timestamp;

  FeedStockModel(
      {required this.date,
      required this.numberfeedStock,
      required this.feedstockId,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'numberfeedStock': numberfeedStock,
      'feedstockId': feedstockId,
      'timestamp': timestamp
    };
  }

  FeedStockModel.fromFirestore(Map<String, dynamic>? firestore)
      : date = firestore?['date'],
        timestamp = firestore?['timestamp'],
        feedstockId = firestore?['feedstockId'],
        numberfeedStock = firestore?['numberfeedStock'];
}
