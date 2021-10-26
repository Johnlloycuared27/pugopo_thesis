import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/buyer_bloc.dart';
import 'package:thesis_auth/src/bloc/editbuyer_bloc.dart';
import 'package:thesis_auth/src/bloc/feed_bloc.dart';
import 'package:thesis_auth/src/bloc/feed_editBloc.dart';
import 'package:thesis_auth/src/routes.dart';
import 'package:thesis_auth/src/screens/login.dart';
import 'package:thesis_auth/src/services/firestore_service.dart';

final buyerBloc = BuyerBloc();
final firestoreService = FirestoreService();
final feedBloc = FeedBloc();
final editfeedBloc = editFeedBloc();
final editbuyerBloc = editBuyerBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => buyerBloc),
        Provider(create: (context) => editbuyerBloc),
        StreamProvider(
            initialData: null,
            create: (context) => firestoreService.fetchpoultry()),
        StreamProvider(
          initialData: null,
          create: (context) => firestoreService.getfeedstocks(),
        ),
        Provider(create: (context) => feedBloc),
        Provider(create: (context) => editfeedBloc),
      ],
      child: PlatFormApp(),
    );
  }

  @override
  void dispose() {
    buyerBloc.dispose();
    feedBloc.dispose();
    super.dispose();
  }
}

class PlatFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      onGenerateRoute: Routes.materialRoutes,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
