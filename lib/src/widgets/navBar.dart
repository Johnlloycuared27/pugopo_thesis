import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/styles/text.dart';

abstract class AppNavbar {
  static SliverAppBar materialNavBar(
      {required String title, TabBar? tabBar, required bool pinned}) {
    return SliverAppBar(
      title: Center(
        child: Text(
          title,
          style: TextStyles.navTitleMaterial,
        ),
      ),
      backgroundColor: AppColors.darkblue,
      bottom: tabBar,
      floating: true,
      pinned: (pinned == false) ? true : pinned,
      snap: true,
    );
  }
}
