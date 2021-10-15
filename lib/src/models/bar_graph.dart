class Harvest {
  final int? harvestVal;
  final String? colorVal;
  final String? harvestmonth;

  Harvest({this.colorVal, this.harvestVal, this.harvestmonth});

  Harvest.fromMap(Map<String, dynamic> map)
      : assert(map['harvestVal']),
        assert(map['harvestMonth']),
        assert(map['colorVal']),
        harvestVal = map['harvestVal'],
        harvestmonth = map['harvestMonth'],
        colorVal = map['colorVal'];

  @override
  String toString() => 'Record<$harvestVal:$harvestmonth:$colorVal>';
}
