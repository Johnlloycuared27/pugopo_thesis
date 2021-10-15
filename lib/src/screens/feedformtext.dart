import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thesis_auth/src/bloc/feed_bloc.dart';
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
  Widget build(BuildContext context) {
    var feedBloc = Provider.of<FeedBloc>(context);

    return AppSliverScaffold.materialSliverScaffold(
        navTitle: 'Add Buyer             ',
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
                materialIcon: FontAwesomeIcons.peopleCarry,
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
                materialIcon: FontAwesomeIcons.peopleCarry,
                errorText: snapshot.hasError ? snapshot.error.toString() : "",
                onChanged: feedBloc.changenumfeedstock,
              );
            }),
        AppButton(
            buttonText: 'Add Image',
            buttonType: ButtonType.Straw,
            onPressed: () {}),
        StreamBuilder<bool>(
            stream: feedBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Submitt',
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                onPressed: feedBloc.addFeedStock,
              );
            })
      ],
    );
  }
}
