import 'package:flutter/material.dart';
import 'package:thesis_auth/src/screens/Harvest_stocks.dart';
import 'package:thesis_auth/src/screens/Stocks_screen.dart';
import 'package:thesis_auth/src/screens/addbuyer.dart';
import 'package:thesis_auth/src/screens/edit_buyer.dart';
import 'package:thesis_auth/src/screens/feedformtext.dart';
import 'package:thesis_auth/src/screens/feedstock_home.dart';
import 'package:thesis_auth/src/screens/signup.dart';
import 'package:thesis_auth/src/screens/welcomePage.dart';
import 'package:thesis_auth/src/screens/landing.dart';
import 'package:thesis_auth/src/screens/login.dart';

import 'package:thesis_auth/src/widgets/logout.dart';
import 'package:thesis_auth/src/widgets/profile.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/landing":
        return MaterialPageRoute(builder: (context) => Landing());
      case "/signup":
        return MaterialPageRoute(builder: (context) => RegistrationScreen());
      case "/login":
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case "/profile":
        return MaterialPageRoute(builder: (context) => proFile());
      case "/logout":
        return MaterialPageRoute(builder: (context) => logOut());
      case "/welcome":
        return MaterialPageRoute(builder: (context) => welcomePage());
      case "/editbuyer":
        return MaterialPageRoute(builder: (context) => EditBuyer());
      case "/grahp":
        return MaterialPageRoute(builder: (context) => EditBuyer());
      case "/stockhome":
        return MaterialPageRoute(builder: (context) => stockHome());
      case "/harveststock":
        return MaterialPageRoute(builder: (context) => harvestStock());
      case "/feedstockhome":
        return MaterialPageRoute(builder: (context) => feedHomePage());
      case "/feedstockpage":
        return MaterialPageRoute(builder: (context) => feedTextForm());
      case "/addbuyer":
        return MaterialPageRoute(builder: (context) => addBuyer());
      default:
        var routeArray = settings.name!.split('/');
        if (settings.name!.contains('/editbuyer/')) {
          return MaterialPageRoute(
              builder: (context) => EditBuyer(
                    buyerId: routeArray[2],
                  ));
        }
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
