class VitaminStock {
  final String? stockId;
  final String? date;
  final String? numberStock;

  VitaminStock({this.date, this.numberStock, required this.stockId});

  factory VitaminStock.fromJson(Map<String, dynamic> json) {
    return VitaminStock(
        date: json['date'],
        numberStock: json['numberStock'],
        stockId: json['stockId']);
  }

  Map<String, dynamic> toMap() {
    return {'date': date, 'numberStock': numberStock, 'stockId': stockId};
  }
}
