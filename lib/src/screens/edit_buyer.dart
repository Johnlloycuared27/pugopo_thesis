import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/editbuyer_bloc.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';
import 'package:thesis_auth/src/styles/base.dart';
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

  @override
  void initState() {
    var editbuyerBloc = Provider.of<editBuyerBloc>(context, listen: false);
    editbuyerBloc.buyerSaved.listen((saved) {
      if (saved != isEmpty && saved == true && context != isEmpty) {
        Fluttertoast.showToast(
            msg: "Update Success",
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
    var editbuyerBloc = Provider.of<editBuyerBloc>(context);

    return FutureBuilder<Buyers>(
      future: editbuyerBloc.fetchBuyer(widget.buyerId!),
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
          loadValues(editbuyerBloc, existingBuyer);
        } else {
          //Add Logic

        }
        return AppSliverScaffold.materialSliverScaffold(
            navTitle: 'Edit Suctomer             ',
            pageBody: pageBody(editbuyerBloc, context, existingBuyer),
            context: context);
      },
    );
  }

  Widget pageBody(
      editBuyerBloc editbuyerBloc, BuildContext context, Buyers existingBuyer) {
    var items = Provider.of<List<String>?>(context);
    return ListView(
      children: <Widget>[
        StreamBuilder<String>(
            stream: editbuyerBloc.poultry,
            builder: (context, snapshot) {
              return AppDropDownButton(
                hintText: 'Unit Type',
                items: items,
                value: snapshot.data,
                onChanged: editbuyerBloc.changePoultry,
              );
            }),
        StreamBuilder<String>(
            stream: editbuyerBloc.buyerName,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Customer Name',
                materialIcon: FontAwesomeIcons.userAlt,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText:
                    (existingBuyer != isEmpty) ? existingBuyer.buyerName : null,
                onChanged: editbuyerBloc.changeBuyerName,
              );
            }),
        StreamBuilder<int>(
            stream: editbuyerBloc.contactNumber,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Contact Number',
                materialIcon: FontAwesomeIcons.phoneAlt,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: (existingBuyer != isEmpty)
                    ? existingBuyer.contactNum.toString()
                    : null,
                onChanged: editbuyerBloc.changeContact,
              );
            }),
        StreamBuilder<String>(
            stream: editbuyerBloc.address,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Address',
                materialIcon: FontAwesomeIcons.mapMarkerAlt,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText:
                    (existingBuyer != isEmpty) ? existingBuyer.address : null,
                onChanged: editbuyerBloc.changeAddress,
              );
            }),
        StreamBuilder<String>(
            stream: editbuyerBloc.date,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Date',
                materialIcon: FontAwesomeIcons.calendarAlt,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText:
                    (existingBuyer != isEmpty) ? existingBuyer.date : null,
                onChanged: editbuyerBloc.changeDate,
              );
            }),
        StreamBuilder<int>(
            stream: editbuyerBloc.numberTray,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Number of tray',
                materialIcon: FontAwesomeIcons.layerGroup,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: (existingBuyer != isEmpty)
                    ? existingBuyer.numofTray.toString()
                    : null,
                onChanged: editbuyerBloc.changeNumtray,
              );
            }),
        StreamBuilder<double>(
            stream: editbuyerBloc.price,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Price',
                materialIcon: FontAwesomeIcons.dollarSign,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: (existingBuyer != isEmpty)
                    ? existingBuyer.unitPrice.toString()
                    : null,
                onChanged: editbuyerBloc.changePrice,
              );
            }),
        StreamBuilder<bool>(
            stream: editbuyerBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Submitt',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: editbuyerBloc.editBuyer,
              );
            }),
        StreamBuilder<bool>(
          stream: editbuyerBloc.isUploading,
          builder: (context, snapshot) {
            return (!snapshot.hasData || snapshot.data == false)
                ? Container()
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        StreamBuilder<String>(
            stream: editbuyerBloc.imageUrl,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == "")
                return AppButton(
                  buttonType: ButtonType.Straw,
                  buttonText: 'Add Image',
                  onPressed: editbuyerBloc.pickImage,
                );

              return Column(
                children: <Widget>[
                  Padding(
                    padding: BaseStyles.listPadding,
                    child: Image.network(snapshot.data!),
                  ),
                  AppButton(
                    buttonType: ButtonType.Straw,
                    buttonText: 'Change Image',
                    onPressed: editbuyerBloc.pickImage,
                  )
                ],
              );
            }),
      ],
    );
  }

  loadValues(
    editBuyerBloc buyerBloc,
    Buyers buyer,
  ) {
    buyerBloc.changeBuyer(buyer);
    if (buyer != isEmpty) {
      //Edit
      buyerBloc.changeBuyerName(buyer.buyerName!);
      buyerBloc.changeContact(buyer.contactNum.toString());
      buyerBloc.changeAddress(buyer.address!);
      buyerBloc.changeDate(buyer.date!);
      buyerBloc.changeNumtray(buyer.numofTray.toString());
      buyerBloc.changePrice(buyer.unitPrice.toString());
      buyerBloc.changePoultry(buyer.Poultry!);
      buyerBloc.changeimageUrl(buyer.imageUrl ?? '');
    } else {
      buyerBloc.changeBuyerName('');
      buyerBloc.changeContact('');
      buyerBloc.changeAddress('');
      buyerBloc.changeDate('');
      buyerBloc.changeNumtray('');
      buyerBloc.changePrice('');
      buyerBloc.changePoultry('');
      buyerBloc.changeimageUrl('');
    }
  }
}
