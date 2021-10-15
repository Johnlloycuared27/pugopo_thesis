class HarStock {
  final String? stockId;
  final String? date;
  final String? numberStock;

  HarStock({this.date, this.numberStock, required this.stockId});

  factory HarStock.fromJson(Map<String, dynamic> json) {
    return HarStock(
        date: json['date'],
        numberStock: json['numberStock'],
        stockId: json['stockId']);
  }

  Map<String, dynamic> toMap() {
    return {'date': date, 'numberStock': numberStock, 'stockId': stockId};
  }
}
