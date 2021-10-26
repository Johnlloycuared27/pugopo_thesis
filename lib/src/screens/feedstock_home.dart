import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/feed_bloc.dart';
import 'package:thesis_auth/src/models/feedstock_model.dart';
import 'package:thesis_auth/src/styles/base.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/styles/text.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';

class feedHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var feedBloc = Provider.of<FeedBloc>(context);
    return AppSliverScaffold.materialSliverScaffold(
        navTitle: 'Add Feed Stocks         ',
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var feedStock = snapshot.data![index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.layers),
                          title: Text(
                            feedStock.date!,
                            style: TextStyles.subtitle,
                          ),
                          trailing: Text(
                            feedStock.numberfeedStock.toString(),
                            style: TextStyles.subtitle2,
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed('/editfeed/${feedStock.feedstockId}'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: BaseStyles.listFieldHorizontal),
                          child: Divider(color: AppColors.lightgray),
                        )
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                color: AppColors.darkgray,
                child: Center(
                    child: Text(
                  'Total Feed Stocks: ',
                  style: TextStyles.subtitle3,
                )),
              )
            ],
          );
        }),
    floatingActionButton: FloatingActionButton(
      backgroundColor: AppColors.straw,
      child: Icon(Icons.add),
      onPressed: () => Navigator.of(context).pushNamed('/feedstockpage'),
    ),
  );
}
