import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/feed_bloc.dart';
import 'package:thesis_auth/src/models/feedstock_model.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/widgets/feed_card.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';

class feedHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var feedBloc = Provider.of<FeedBloc>(context);
    return AppSliverScaffold.materialSliverScaffold(
        navTitle: 'Add Buyer         ',
        pageBody: pagebody(context, feedBloc),
        context: context);
  }
}

Widget pagebody(BuildContext context, FeedBloc feedBloc) {
  return Scaffold(
    body: StreamBuilder<List<FeedStockModel>>(
        stream: feedBloc.fetchFeedStock(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var feedStock = snapshot.data![index];
              return feedCard(
                date: feedStock.date,
                numberfeedstock: feedStock.numberfeedStock,
              );
            },
          );
        }),
    floatingActionButton: FloatingActionButton(
      backgroundColor: AppColors.straw,
      child: Icon(Icons.add),
      onPressed: () => Navigator.of(context).pushNamed('/feedstockpage'),
    ),
  );
}
