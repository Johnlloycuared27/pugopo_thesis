import 'package:flutter/material.dart';
import 'package:thesis_auth/src/screens/Header_drawer.dart';

// ignore: camel_case_types
class logOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout Page'),
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
    );
  }
}
