import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thesis_auth/src/styles/base.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/styles/text.dart';

class AppCard extends StatelessWidget {
  final String? buyerName;
  final String? poultry;
  final int? number;
  final String? address;
  final String? date;
  final int? numberOfTray;
  final double? price;
  final String? note;

  final formatCurrency = NumberFormat.simpleCurrency();

  AppCard({
    required this.buyerName,
    required this.poultry,
    required this.number,
    required this.address,
    required this.date,
    required this.numberOfTray,
    required this.price,
    this.note = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseStyles.listPadding,
      padding: BaseStyles.listPadding,
      decoration: BoxDecoration(
          boxShadow: BaseStyles.boxShadow,
          color: Colors.white,
          border: Border.all(
            color: AppColors.darkblue,
            width: BaseStyles.borderWidth,
          ),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, bottom: 10.0, top: 10.0),
                child: Image.asset(
                  'assets/images/logo2.jpg',
                  height: 100.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    buyerName!,
                    style: TextStyles.subtitle2,
                  ),
                  Text(
                    poultry!,
                    style: TextStyles.body,
                  ),
                  Text(
                    ('$number'),
                    style: TextStyles.body,
                  ),
                  Text(
                    address!,
                    style: TextStyles.body,
                  ),
                  Text(
                    date!,
                    style: TextStyles.body,
                  ),
                  Text(
                    ('$numberOfTray'),
                    style: TextStyles.bodyLightBlue,
                  ),
                  Text(
                    ('${formatCurrency.format(price)}'),
                    style: TextStyles.bodyRed,
                  )
                ],
              )
            ],
          ),
          Text(
            'This is the note space',
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }
}
