import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';
import 'package:thesis_auth/src/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class BuyerBloc {
  final _buyerName = BehaviorSubject<String>();
  final _poultry = BehaviorSubject<String>();
  final _contactNumber = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _date = BehaviorSubject<String>();
  final _numberTray = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _buyerSaved = PublishSubject<bool>();
  final _buyer = BehaviorSubject<Buyers>();

  final db = FirestoreService();

  var uuid = Uuid();

//get

  Stream<String> get buyerName =>
      _buyerName.stream.transform(validateBuyerName);
  Stream<String> get poultry => _poultry.stream;
  Stream<int> get contactNumber =>
      _contactNumber.stream.transform(validateContact);
  Stream<String> get address => _address.stream;
  Stream<String> get date => _date.stream;
  Stream<int> get numberTray =>
      _numberTray.stream.transform(validateNumberTray);
  Stream<double> get price => _price.stream.transform(validatePrice);
  Stream<bool> get isValid => CombineLatestStream.combine7(
      buyerName,
      poultry,
      contactNumber,
      address,
      date,
      numberTray,
      price,
      (a, b, c, d, e, f, g) => true);
  String? get poultry_Type => _poultry.valueOrNull;

  Object? get isEmpty => null;

  static Object? get isnull => null;

  Stream<List<Buyers>>? poultryType() => db.fetchBuyerByPoultry();
  Stream<bool> get buyerSaved => _buyerSaved.stream;
  Future<Buyers> fetchBuyer(String buyerId) => db.fectchBuyer(buyerId);

//set

  Function(String) get changeBuyerName => _buyerName.sink.add;
  Function(String) get changePoultry => _poultry.sink.add;
  Function(String) get changeContact => _contactNumber.sink.add;
  Function(String) get changeAddress => _address.sink.add;
  Function(String) get changeDate => _date.sink.add;
  Function(String) get changeNumtray => _numberTray.sink.add;
  Function(String) get changePrice => _price.sink.add;
  Function(Buyers) get changeBuyer => _buyer.sink.add;

  dispose() {
    _buyerName.close();
    _poultry.close();
    _contactNumber.close();
    _address.close();
    _date.close();
    _numberTray.close();
    _price.close();
    _buyerSaved.close();
    _buyer.close();
  }

  Future<void> editBuyer() async {
    var buyer = Buyers(
      buyerName: _buyerName.value.trim(),
      Poultry: _poultry.value,
      contactNum: int.parse(_contactNumber.value),
      address: _address.value,
      date: _date.value,
      numofTray: int.parse(_numberTray.value),
      unitPrice: double.parse(_price.value),
      buyerId: _buyer.value.buyerId,
      approved: true,
    );
    return db
        .setBuyer(buyer)
        .then((value) => _buyerSaved.sink.add(true))
        .catchError((error) => _buyerSaved.sink.add(false));
  }

  Future<void> addBuyer() async {
    var buyer = Buyers(
      buyerName: _buyerName.value.trim(),
      Poultry: _poultry.value,
      contactNum: int.parse(_contactNumber.value),
      address: _address.value,
      date: _date.value,
      numofTray: int.parse(_numberTray.value),
      unitPrice: double.parse(_price.value),
      buyerId: uuid.v4(),
      approved: true,
    );
    return db
        .setBuyer(buyer)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //validator
  final validatePrice =
      StreamTransformer<String, double>.fromHandlers(handleData: (price, sink) {
    try {
      sink.add(double.parse(price));
    } catch (error) {
      sink.addError('must be a number');
    }
  });

  final validateContact = StreamTransformer<String, int>.fromHandlers(
      handleData: (contactNumber, sink) {
    try {
      sink.add(int.parse(contactNumber));
    } catch (error) {
      sink.addError('Must be a whole number');
    }
  });

  final validateNumberTray = StreamTransformer<String, int>.fromHandlers(
      handleData: (numberTray, sink) {
    try {
      sink.add(int.parse(numberTray));
    } catch (error) {
      sink.addError('must be a whole number');
    }
  });

  final validateBuyerName = StreamTransformer<String, String>.fromHandlers(
      handleData: (buyerName, sink) {
    if (buyerName != isnull) {
      if (buyerName.length >= 3 && buyerName.length <= 30) {
        sink.add(buyerName.trim());
      } else {
        if (buyerName.length < 3) {
          sink.addError('3 character minimun');
        } else {
          sink.addError('20 character maximum');
        }
      }
    }
  });
}
