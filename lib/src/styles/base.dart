import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/color.dart';

abstract class BaseStyles {
  static double get borderRadius => 15.0;

  static double get borderWidth => 1.5;

  static double get listFieldHorizontal => 25.0;

  static double get listFieldVertical => 5.0;

  static double get animationOffset => 2.0;

  static EdgeInsets get listPadding {
    return EdgeInsets.symmetric(
        horizontal: listFieldHorizontal, vertical: listFieldVertical);
  }

  static List<BoxShadow> get boxShadow {
    return [
      BoxShadow(
        color: AppColors.darkgray.withOpacity(.5),
        offset: Offset(1.0, 2.0),
        blurRadius: 2.0,
      )
    ];
  }

  static List<BoxShadow> get boxShadowPressed {
    return [
      BoxShadow(
        color: AppColors.darkgray.withOpacity(.5),
        offset: Offset(1.0, 1.0),
        blurRadius: 1.0,
      )
    ];
  }

  static Widget iconPrefix(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(icon, size: 22.0, color: AppColors.darkgray),
    );
  }
}
