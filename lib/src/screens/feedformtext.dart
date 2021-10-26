import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/feed_bloc.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/widgets/button.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';
import 'package:thesis_auth/src/widgets/textfield.dart';

class feedTextForm extends StatefulWidget {
  @override
  _feedTextFormState createState() => _feedTextFormState();
}

class _feedTextFormState extends State<feedTextForm> {
  Object? get isEmpty => null;

  @override
  void initState() {
    var feedBloc = Provider.of<FeedBloc>(context, listen: false);
    feedBloc.feedSaved.listen((saved) {
      if (saved != isEmpty && saved == true) {
        Fluttertoast.showToast(
            msg: "Stock Saved",
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
    var feedBloc = Provider.of<FeedBloc>(context);

    return AppSliverScaffold.materialSliverScaffold(
        navTitle: 'Add Feed Stocks             ',
        pageBody: pageBody(feedBloc, context),
        context: context);
  }

  Widget pageBody(
    FeedBloc feedBloc,
    BuildContext context,
  ) {
    return ListView(
      children: <Widget>[
        StreamBuilder<String>(
            stream: feedBloc.date,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Date',
                materialIcon: FontAwesomeIcons.calendarAlt,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                onChanged: feedBloc.changeDate,
              );
            }),
        StreamBuilder<int>(
            stream: feedBloc.numberfeedstock,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Sack of Feeds',
                materialIcon: FontAwesomeIcons.layerGroup,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                onChanged: feedBloc.changenumfeedstock,
              );
            }),
        AppButton(
            buttonText: 'Take Out Stock',
            buttonType: ButtonType.Straw,
            onPressed: () {}),
        StreamBuilder<bool>(
            stream: feedBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Add Stock',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: feedBloc.addFeedStock,
              );
            }),
        ListTile(
          title: Text(''),
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            //  _pickDate(context, feedBloc).then((value) {
            //if (value != null) {
            //   feedBloc.changeDate1;
            //   }
            //  });
          },
        )
      ],
    );
  }

  // Future<DateTime?> _pickDate(BuildContext context, FeedBloc feedBloc) async {
  // final DateTime? picked = await showDatePicker(
  //    context: context,
  //   initialDate: ,
  //  firstDate: DateTime(2019),
  //  lastDate: DateTime(2050));

  //  if (picked != null) return picked;
  //}
}
