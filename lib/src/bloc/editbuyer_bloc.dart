import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thesis_auth/src/services/firebasestorage_service.dart';
import 'package:uuid/uuid.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';
import 'package:thesis_auth/src/services/firestore_service.dart';

class editBuyerBloc {
  final _buyerName = BehaviorSubject<String>();
  final _poultry = BehaviorSubject<String>();
  final _contactNumber = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _date = BehaviorSubject<String>();
  final _numberTray = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _buyerSaved = PublishSubject<bool>();
  final _buyer = BehaviorSubject<Buyers>();
  final _imageUrl = BehaviorSubject<String>();
  final _isUploading = BehaviorSubject<bool>();

  final db = FirestoreService();

  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  final storageService = FirebaseStoreService();

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
  Stream<String> get imageUrl => _imageUrl.stream;
  Stream<bool> get isValid => CombineLatestStream.combine7(
      buyerName,
      poultry,
      contactNumber,
      address,
      date,
      numberTray,
      price,
      (a, b, c, d, e, f, g) => true);
  String? get poultry_tType => _poultry.valueOrNull;

  Object? get isEmpty => null;

  static Object? get isnull => null;

  Stream<List<Buyers>>? poultryType() => db.fetchBuyerByPoultry();
  Stream<bool> get buyerSaved => _buyerSaved.stream;
  Future<Buyers> fetchBuyer(String buyerId) => db.fectchBuyer(buyerId);
  Stream<bool> get isUploading => _isUploading.stream;

//set

  Function(String) get changeBuyerName => _buyerName.sink.add;
  Function(String) get changePoultry => _poultry.sink.add;
  Function(String) get changeContact => _contactNumber.sink.add;
  Function(String) get changeAddress => _address.sink.add;
  Function(String) get changeDate => _date.sink.add;
  Function(String) get changeNumtray => _numberTray.sink.add;
  Function(String) get changePrice => _price.sink.add;
  Function(Buyers) get changeBuyer => _buyer.sink.add;
  Function(String) get changeimageUrl => _imageUrl.sink.add;

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
    _imageUrl.close();
    _isUploading.close();
  }

  Future<void> editBuyer() async {
    var buyer = Buyers(
        timestamp: Timestamp.now(),
        buyerName: _buyerName.value.trim(),
        Poultry: _poultry.value,
        contactNum: int.parse(_contactNumber.value),
        address: _address.value,
        date: _date.value,
        numofTray: int.parse(_numberTray.value),
        unitPrice: double.parse(_price.value),
        buyerId: _buyer.value.buyerId,
        imageUrl: _imageUrl.value);
    return db
        .editBuyer(buyer)
        .then((value) => _buyerSaved.sink.add(true))
        .catchError((error) => _buyerSaved.sink.add(false));
  }

  pickImage() async {
    XFile? image;
    File croppedFile;

    //Get Image From Device
    image = await _picker.pickImage(source: ImageSource.gallery);

    //Upload to Firebase
    if (image != null) {
      _isUploading.sink.add(true);

      //Get Image Properties
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(image.path);

      //CropImage
      if (properties.height! > properties.width!) {
        var yoffset = (properties.height! - properties.width!) / 2;
        croppedFile = await FlutterNativeImage.cropImage(image.path, 0,
            yoffset.toInt(), properties.width!, properties.width!);
      } else if (properties.width! > properties.height!) {
        var xoffset = (properties.width! - properties.height!) / 2;
        croppedFile = await FlutterNativeImage.cropImage(image.path,
            xoffset.toInt(), 0, properties.height!, properties.height!);
      } else {
        croppedFile = File(image.path);
      }

      //Resize
      File compressedFile = await FlutterNativeImage.compressImage(
          croppedFile.path,
          quality: 100,
          targetHeight: 600,
          targetWidth: 600);

      var imageUrl =
          await storageService.uploadCustomerImage(compressedFile, uuid.v4());
      changeimageUrl(imageUrl);
      _isUploading.sink.add(false);
    } else {
      print('No Path Received');
    }
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
