import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/base.dart';
import 'package:thesis_auth/src/styles/buttons.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/styles/text.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final ButtonType buttonType;
  final void Function() onPressed;

  AppButton(
      {required this.buttonText,
      required this.buttonType,
      required this.onPressed});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle;
    Color buttonColor;

    switch (widget.buttonType) {
      case ButtonType.Straw:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.straw;
        break;
      case ButtonType.LightBlue:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.lightblue;
        break;
      case ButtonType.DarkBlue:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.darkblue;
        break;
      case ButtonType.DarkGray:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.darkgray;
        break;
      case ButtonType.Disabled:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.lightgray;
        break;
      default:
        fontStyle = TextStyles.buttonTextLight;
        buttonColor = AppColors.lightgray;
        break;
    }

    return AnimatedContainer(
      padding: EdgeInsets.only(
          top: (pressed)
              ? BaseStyles.listFieldVertical + BaseStyles.animationOffset
              : BaseStyles.listFieldVertical,
          bottom: (pressed)
              ? BaseStyles.listFieldVertical - BaseStyles.animationOffset
              : BaseStyles.listFieldVertical,
          left: BaseStyles.listFieldHorizontal,
          right: BaseStyles.listFieldHorizontal),
      child: GestureDetector(
        child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
            boxShadow:
                pressed ? BaseStyles.boxShadowPressed : BaseStyles.boxShadow,
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: fontStyle,
            ),
          ),
        ),
        onTapDown: (details) {
          setState(() {
            if (widget.buttonType != ButtonType.Disabled) pressed = !pressed;
          });
        },
        onTapUp: (details) {
          setState(() {
            if (widget.buttonType != ButtonType.Disabled) pressed = !pressed;
          });
        },
        onTap: () {
          if (widget.buttonType != ButtonType.Disabled) {
            widget.onPressed();
          }
        },
      ),
      duration: Duration(milliseconds: 20),
    );
  }
}

enum ButtonType { LightBlue, Straw, Disabled, DarkGray, DarkBlue }
