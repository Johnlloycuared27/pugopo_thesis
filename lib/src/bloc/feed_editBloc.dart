import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thesis_auth/src/models/feedstock_model.dart';
import 'package:thesis_auth/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class editFeedBloc {
  final _date = BehaviorSubject<String>();
  final _numberfeedstock = BehaviorSubject<String>();
  final _feedSaved = PublishSubject<bool>();
  final _cfeed = BehaviorSubject<FeedStockModel>();
  final db = FirestoreService();
  final _date1 = BehaviorSubject<DateTime>();
  var uuid = Uuid();

//get
  Stream<String> get date => _date.stream.transform(validateDate);
  Stream<int> get numberfeedstock =>
      _numberfeedstock.stream.transform(validateNumFeedStock);
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(date, numberfeedstock, (a, b) => true);

  Stream<List<FeedStockModel>> fetchFeedStock() => db.getfeedstocks();
  Stream<bool> get feedSaved => _feedSaved.stream;
  Future<FeedStockModel> fetchfeed(String feedstockId) =>
      db.fectchfeed(feedstockId);
  Future<void>? removefeed(String feedstockId) =>
      db.removefeedStock(feedstockId);
  Stream<DateTime> get date1 => _date1.stream;

//set
  Function(DateTime) get changeDate1 => _date1.sink.add;
  Function(String) get changeDate => _date.sink.add;
  Function(String) get changenumfeedstock => _numberfeedstock.sink.add;
  Function(FeedStockModel) get changeFeed => _cfeed.sink.add;

  static Object? get isnull => null;

  dispose() {
    _date.close();
    _numberfeedstock.close();
    _feedSaved.close();
    _cfeed.close();
    _date1.close();
  }

  //validator
  final validateNumFeedStock = StreamTransformer<String, int>.fromHandlers(
      handleData: (numberfeedstock, sink) {
    try {
      sink.add(int.parse(numberfeedstock));
    } catch (error) {
      sink.addError('must be a number');
    }
  });

  final validateDate =
      StreamTransformer<String, String>.fromHandlers(handleData: (date, sink) {
    if (date != isnull) {
      if (date.length >= 3 && date.length <= 30) {
        sink.add(date.trim());
      } else {
        if (date.length == '') {
          sink.addError('Please fill up the text field');
        } else {
          sink.addError('20 character maximum');
        }
      }
    }
  });

  Future<void> editFeedStock() async {
    var feedStock = FeedStockModel(
        timestamp: Timestamp.now(),
        date: _date.value,
        numberfeedStock: int.parse(_numberfeedstock.value),
        feedstockId: _cfeed.value.feedstockId);
    return db
        .addfeedstocks(feedStock)
        .then((value) => _feedSaved.sink.add(true))
        .catchError((error) => _feedSaved.sink.add(false));
  }

  removeFeeds(String feedstockId) {
    db.removefeedStock(feedstockId);
  }
}
