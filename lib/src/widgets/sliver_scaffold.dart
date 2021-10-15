import 'package:flutter/material.dart';
import 'package:thesis_auth/src/widgets/navBar.dart';

abstract class AppSliverScaffold {
  static Scaffold materialSliverScaffold(
      {required String navTitle,
      required Widget pageBody,
      required BuildContext context}) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                AppNavbar.materialNavBar(
                  title: navTitle,
                  pinned: true,
                )
              ];
            },
            body: pageBody));
  }
}
