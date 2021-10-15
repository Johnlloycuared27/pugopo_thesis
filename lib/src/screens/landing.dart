import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thesis_auth/src/screens/Header_drawer.dart';

class Landing extends StatefulWidget {
  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Material MyItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(color: new Color(color), fontSize: 20.0),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            MyHeaderDrawer(),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/landing');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/logout');
              },
            ),
          ],
        ),
      ),
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
      children: <Widget>[
        GestureDetector(
            child: MyItems(Icons.graphic_eq, "Buyer List", 0xffed622b),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/welcome');
            }),
        GestureDetector(
          child: MyItems(Icons.bookmark, "Harvest Chart", 0xff26cb3c),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/welcome');
          },
        ),
        GestureDetector(
          child: MyItems(Icons.settings, "Poultry Stocks", 0xffff3266),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/stockhome');
          },
        ),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, 150),
        StaggeredTile.extent(1, 150),
        StaggeredTile.extent(1, 150),
      ],
    );
  }
}
