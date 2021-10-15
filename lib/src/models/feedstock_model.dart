class FeedStockModel {
  final String? date;
  final int? numberfeedStock;
  final String? feedstockId;

  FeedStockModel(
      {required this.date,
      required this.numberfeedStock,
      required this.feedstockId});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'numberfeedStock': numberfeedStock,
      'feedstockId': feedstockId
    };
  }

  FeedStockModel.fromFirestore(Map<String, dynamic> firestore)
      : date = firestore['date'],
        feedstockId = firestore['feedstockId'],
        numberfeedStock = firestore['numberfeedStock'];
}
