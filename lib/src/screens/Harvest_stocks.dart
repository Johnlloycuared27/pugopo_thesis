import 'package:flutter/material.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';

class harvestStock extends StatefulWidget {
  @override
  State<harvestStock> createState() => _harvestStockState();
}

class _harvestStockState extends State<harvestStock> {
  @override
  Widget build(BuildContext context) {
    return AppSliverScaffold.materialSliverScaffold(
        navTitle: 'Edit Buyer         ',
        pageBody: pagebody(context),
        context: context);
  }

  Widget pagebody(BuildContext context) {
    return Scaffold();
  }
}
