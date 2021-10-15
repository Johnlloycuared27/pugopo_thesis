import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/base.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/styles/text.dart';

class feedCard extends StatelessWidget {
  final String? date;
  final int? numberfeedstock;

  feedCard({
    required this.date,
    required this.numberfeedstock,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' ',
                    style: TextStyles.body,
                  ),
                  Text(
                    date!,
                    style: TextStyles.body,
                  ),
                  Text(
                    ('$numberfeedstock'),
                    style: TextStyles.body,
                  ),
                  Text(
                    ' ',
                    style: TextStyles.body,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
