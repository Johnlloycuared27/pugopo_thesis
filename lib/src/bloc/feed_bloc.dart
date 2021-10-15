import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:thesis_auth/src/models/feedstock_model.dart';
import 'package:thesis_auth/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class FeedBloc {
  final _date = BehaviorSubject<String>();
  final _numberfeedstock = BehaviorSubject<String>();

  final db = FirestoreService();
  var uuid = Uuid();

//get
  Stream<String> get date => _date.stream.transform(validateDate);
  Stream<int> get numberfeedstock =>
      _numberfeedstock.stream.transform(validateNumFeedStock);
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(date, numberfeedstock, (a, b) => true);

  Stream<List<FeedStockModel>> fetchFeedStock() => db.getfeedstocks();

//set
  Function(String) get changeDate => _date.sink.add;
  Function(String) get changenumfeedstock => _numberfeedstock.sink.add;

  static Object? get isnull => null;

  dispose() {
    _date.close();
    _numberfeedstock.close();
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
        if (date.length < 3) {
          sink.addError('3 character minimun');
        } else {
          sink.addError('20 character maximum');
        }
      }
    }
  });

  Future<void> addFeedStock() async {
    var feedStock = FeedStockModel(
        date: _date.value,
        numberfeedStock: int.parse(_numberfeedstock.value),
        feedstockId: uuid.v4());
    return db
        .savefeedstocks(feedStock)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
