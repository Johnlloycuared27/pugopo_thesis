import 'package:flutter/material.dart';
import 'package:thesis_auth/src/widgets/navBar.dart';
import 'package:thesis_auth/src/widgets/profile.dart';
import 'package:thesis_auth/src/widgets/stocks.dart';

class stockHome extends StatefulWidget {
  static TabBar get vendorTabBar {
    return TabBar(
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.list),
        ),
        Tab(
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  _stockHomeState createState() => _stockHomeState();
}

class _stockHomeState extends State<stockHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppNavbar.materialNavBar(
                  title: 'Poultry Stocks',
                  pinned: false,
                  tabBar: stockHome.vendorTabBar)
            ];
          },
          body: TabBarView(
            children: <Widget>[stockPage(), proFile()],
          ),
        ),
      ),
    );
  }
}
