import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/feed_editBloc.dart';
import 'package:thesis_auth/src/models/feedstock_model.dart';
import 'package:thesis_auth/src/styles/color.dart';
import 'package:thesis_auth/src/widgets/button.dart';
import 'package:thesis_auth/src/widgets/sliver_scaffold.dart';
import 'package:thesis_auth/src/widgets/textfield.dart';

class editFeed extends StatefulWidget {
  final String? feedstockId;

  editFeed({this.feedstockId});

  @override
  _editFeedState createState() => _editFeedState();
}

class _editFeedState extends State<editFeed> {
  Object? get isEmpty => null;

  FeedStockModel get feedstockId => feedstockId;

  String get feedstockIdd => feedstockIdd;

  @override
  void initState() {
    var editfeedBloc = Provider.of<editFeedBloc>(context, listen: false);
    editfeedBloc.feedSaved.listen((saved) {
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
    var editfeedBloc = Provider.of<editFeedBloc>(context);

    return FutureBuilder<FeedStockModel>(
      future: editfeedBloc.fetchfeed(widget.feedstockId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData && widget.feedstockId != null) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        late FeedStockModel existingBuyer;

        if (widget.feedstockId != null) {
          //Edit Logic
          existingBuyer = snapshot.data!;
          loadValues(editfeedBloc, existingBuyer);
        } else {
          //Add Logic

        }
        return AppSliverScaffold.materialSliverScaffold(
            navTitle: 'Edit Customer             ',
            pageBody: pageBody(editfeedBloc, context, existingBuyer),
            context: context);
      },
    );
  }

  Widget pageBody(
    editFeedBloc editfeedBloc,
    BuildContext context,
    FeedStockModel existingBuyer,
  ) {
    return ListView(
      children: <Widget>[
        StreamBuilder<String>(
            stream: editfeedBloc.date,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Date',
                materialIcon: FontAwesomeIcons.calendarAlt,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: existingBuyer.date ?? "",
                onChanged: editfeedBloc.changeDate,
              );
            }),
        StreamBuilder<int>(
            stream: editfeedBloc.numberfeedstock,
            builder: (context, snapshot) {
              if (snapshot == isEmpty) return Container();
              return AppTextField(
                hintText: 'Sack of Feeds',
                materialIcon: FontAwesomeIcons.layerGroup,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                initialText: existingBuyer.numberfeedStock.toString(),
                onChanged: editfeedBloc.changenumfeedstock,
              );
            }),
        AppButton(
            buttonText: 'Take Out Stock',
            buttonType: ButtonType.Straw,
            onPressed: () {}),
        StreamBuilder<bool>(
            stream: editfeedBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Add Stock',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: editfeedBloc.editFeedStock,
              );
            }),
        AppButton(
            buttonText: 'Delete',
            buttonType: ButtonType.Straw,
            onPressed: () {
              editfeedBloc.removeFeeds(widget.feedstockId!);
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  loadValues(editFeedBloc feedBloc, FeedStockModel feedStock) {
    feedBloc.changeFeed(feedStock);
    if (feedStock != isEmpty) {
      //Edit
      feedBloc.changeDate(feedStock.date!);
      feedBloc.changenumfeedstock(feedStock.numberfeedStock.toString());
    } else {
      feedBloc.changeDate('');
      feedBloc.changenumfeedstock('');
    }
  }
}
