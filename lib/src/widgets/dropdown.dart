import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/base.dart';
import 'package:thesis_auth/src/styles/buttons.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/styles/text.dart';

class AppDropDownButton extends StatelessWidget {
  final List<String>? items;
  final String hintText;
  final String? value;
  final Function(String) onChanged;

  AppDropDownButton(
      {required this.items,
      required this.hintText,
      required this.value,
      required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseStyles.listPadding,
      child: Container(
        height: ButtonStyles.buttonHeight,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Container(width: 35.0),
            Expanded(
              child: Center(
                child: DropdownButton<String>(
                  items: buildMaterialItems(items),
                  value: value,
                  hint: Text(hintText, style: TextStyles.suggestion),
                  style: TextStyles.body,
                  underline: Container(),
                  iconEnabledColor: AppColors.darkblue,
                  onChanged: (value) => onChanged(value as String),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildMaterialItems(List<String>? items) {
    return (items != null)
        ? items
            .map((item) => DropdownMenuItem<String>(
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: TextStyles.subtitle,
                  ),
                  value: item,
                ))
            .toList()
        : [];
  }
}
