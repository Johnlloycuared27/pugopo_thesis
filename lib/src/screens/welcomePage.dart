import 'package:flutter/material.dart';
import 'package:thesis_auth/src/widgets/buyer_widget.dart';
import 'package:thesis_auth/src/widgets/navBar.dart';
import 'package:thesis_auth/src/widgets/profile.dart';

class welcomePage extends StatefulWidget {
  @override
  _welcomePageState createState() => _welcomePageState();

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
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppNavbar.materialNavBar(
                  title: 'Buyer List',
                  pinned: false,
                  tabBar: welcomePage.vendorTabBar)
            ];
          },
          body: TabBarView(
            children: <Widget>[BuyersWidget(), proFile()],
          ),
        ),
      ),
    );
  }
}
