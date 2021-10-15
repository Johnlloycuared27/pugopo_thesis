import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/buyer_bloc.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/widgets/button.dart';
import 'package:thesis_auth/src/widgets/dropdown.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';
import 'package:thesis_auth/src/widgets/textfield.dart';

class EditBuyer extends StatefulWidget {
  final String? buyerId;

  EditBuyer({this.buyerId});

  @override
  _EditBuyerState createState() => _EditBuyerState();
}

class _EditBuyerState extends State<EditBuyer> {
  Object? get isEmpty => null;

  get buyers => null;

  @override
  void initState() {
    var buyerBloc = Provider.of<BuyerBloc>(context, listen: false);
    buyerBloc.buyerSaved.listen((saved) {
      if (saved != isEmpty && saved == true) {
        Fluttertoast.showToast(
            msg: "Product Saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColors.lightblue,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buyerBloc = Provider.of<BuyerBloc>(context);

    return FutureBuilder<Buyers>(
      future: buyerBloc.fetchBuyer(widget.buyerId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData && widget.buyerId != null) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        late Buyers existingBuyer;

        if (widget.buyerId != null) {
          //Edit Logic
          existingBuyer = snapshot.data!;
          loadValues(buyerBloc, existingBuyer);
        } else {
          //Add Logic

        }
        return AppSliverScaffold.materialSliverScaffold(
            navTitle: 'Edit Buyer             ',
            pageBody: pageBody(buyerBloc, context, existingBuyer),
            context: context);
      },
    );
  }

  Widget pageBody(
      BuyerBloc buyerBloc, BuildContext context, Buyers existingBuyer) {
    var items = Provider.of<List<String>?>(context);
    return ListView(
      children: <Widget>[
        StreamBuilder<String>(
            stream: buyerBloc.poultry,
            builder: (context, snapshot) {
              return AppDropDownButton(
                hintText: 'Unit Type',
                items: items,
                value: snapshot.data,
                onChanged: buyerBloc.changePoultry,
              );
            }),
        StreamBuilder<String>(
            stream: buyerBloc.buyerName,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Buyer Name',
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText:
                    (existingBuyer != isEmpty) ? existingBuyer.buyerName : null,
                onChanged: buyerBloc.changeBuyerName,
              );
            }),
        StreamBuilder<int>(
            stream: buyerBloc.contactNumber,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Contact Number',
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: (existingBuyer != isEmpty)
                    ? existingBuyer.contactNum.toString()
                    : null,
                onChanged: buyerBloc.changeContact,
              );
            }),
        StreamBuilder<String>(
            stream: buyerBloc.address,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Address',
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText:
                    (existingBuyer != isEmpty) ? existingBuyer.address : null,
                onChanged: buyerBloc.changeAddress,
              );
            }),
        StreamBuilder<String>(
            stream: buyerBloc.date,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Date',
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText:
                    (existingBuyer != isEmpty) ? existingBuyer.date : null,
                onChanged: buyerBloc.changeDate,
              );
            }),
        StreamBuilder<int>(
            stream: buyerBloc.numberTray,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Number of tray',
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: (existingBuyer != isEmpty)
                    ? existingBuyer.numofTray.toString()
                    : null,
                onChanged: buyerBloc.changeNumtray,
              );
            }),
        StreamBuilder<double>(
            stream: buyerBloc.price,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Price',
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: (existingBuyer != isEmpty)
                    ? existingBuyer.unitPrice.toString()
                    : null,
                onChanged: buyerBloc.changePrice,
              );
            }),
        AppButton(
            buttonText: 'Add Image',
            buttonType: ButtonType.Straw,
            onPressed: () {}),
        StreamBuilder<bool>(
            stream: buyerBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Submitt',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: buyerBloc.editBuyer,
              );
            })
      ],
    );
  }

  loadValues(
    BuyerBloc buyerBloc,
    Buyers buyers,
  ) {
    buyerBloc.changeBuyer(buyers);
    if (buyers != isEmpty) {
      //Edit
      buyerBloc.changeBuyerName(buyers.buyerName!);
      buyerBloc.changeContact(buyers.contactNum.toString());
      buyerBloc.changeAddress(buyers.address!);
      buyerBloc.changeDate(buyers.date!);
      buyerBloc.changeNumtray(buyers.numofTray.toString());
      buyerBloc.changePrice(buyers.unitPrice.toString());
      buyerBloc.changePoultry(buyers.Poultry!);
    } else {
      buyerBloc.changeBuyerName('');
      buyerBloc.changeContact('');
      buyerBloc.changeAddress('');
      buyerBloc.changeDate('');
      buyerBloc.changeNumtray('');
      buyerBloc.changePrice('');
      buyerBloc.changePoultry('');
    }
  }
}
