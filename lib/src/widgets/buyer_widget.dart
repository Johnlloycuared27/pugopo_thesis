import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/buyer_bloc.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/widgets/card.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';

class BuyersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buyerBloc = Provider.of<BuyerBloc>(context);

    return AppSliverScaffold.materialSliverScaffold(
        navTitle: 'Add Customer          ',
        pageBody: pageBody(buyerBloc, context),
        context: context);
  }
}

Widget pageBody(BuyerBloc buyerBloc, BuildContext context) {
  return Scaffold(
    body: StreamBuilder<List<Buyers>>(
        stream: buyerBloc.poultryType(),
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
              var buyers = snapshot.data![index];
              return GestureDetector(
                child: AppCard(
                  buyerName: buyers.buyerName,
                  poultry: buyers.Poultry,
                  number: buyers.contactNum,
                  address: buyers.address,
                  date: buyers.date,
                  numberOfTray: buyers.numofTray,
                  price: buyers.unitPrice,
                  imageUrl: buyers.imageUrl,
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed('/editbuyer/${buyers.buyerId}'),
              );
            },
          );
        }),
    floatingActionButton: FloatingActionButton(
      backgroundColor: AppColors.straw,
      child: Icon(Icons.add),
      onPressed: () => Navigator.of(context).pushNamed('/addbuyer'),
    ),
  );
}
