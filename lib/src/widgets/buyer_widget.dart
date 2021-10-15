import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/buyer_bloc.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';

import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/widgets/card.dart';

class BuyersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buyerBloc = Provider.of<BuyerBloc>(context);

    return Scaffold(
      body: pageBody(
        buyerBloc,
        context,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.straw,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/addbuyer'),
      ),
    );
  }

  Widget pageBody(BuyerBloc buyerBloc, BuildContext context) {
    return StreamBuilder<List<Buyers>>(
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
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed('/editbuyer/${buyers.buyerId}'),
              );
            },
          );
        });
  }
}
