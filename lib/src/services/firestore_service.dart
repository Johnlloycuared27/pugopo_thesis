import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis_auth/src/models/buyer_model.dart';
import 'package:thesis_auth/src/models/feedstock_model.dart';
import 'package:thesis_auth/src/models/harveststock_model.dart';
import 'package:thesis_auth/src/models/vitaminsStock_model.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<String>> fetchpoultry() {
    return _db.collection('types').doc('units').snapshots().map((snapshot) =>
        snapshot
            .data()?['production']
            .map<String>((type) => type.toString())
            .toList());
  }

//editbuyer
  Future<void> editBuyer(Buyers buyer) {
    var options = SetOptions(merge: true);
    return _db
        .collection('buyers')
        .doc(buyer.buyerId)
        .set(buyer.toMap(), options);
  }

//addbuyer
  Future<void> addBuyer(Buyers buyer) {
    var options = SetOptions(merge: true);
    return _db
        .collection('buyers')
        .doc(buyer.buyerId)
        .set(buyer.toMap(), options);
  }

//update buyer
  Future<Buyers> fectchBuyer(String buyerId) {
    return _db
        .collection('buyers')
        .doc(buyerId)
        .get()
        .then((snapshot) => Buyers.fromFirestore(snapshot.data()));
  }

  //get buyer list
  Stream<List<Buyers>> fetchBuyerByPoultry() {
    return _db.collection('buyers').snapshots().map((query) => query.docs).map(
        (snapshot) =>
            snapshot.map((doc) => Buyers.fromFirestore(doc.data())).toList());
  }

  //get harvest stocks
  Stream<List<HarStock>> getharstocks() {
    return _db.collection('harvest_stock').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => HarStock.fromJson(doc.data())).toList());
  }

  //upset
  Future<void> setharstocks(HarStock harStock) {
    var options = SetOptions(merge: true);
    return _db
        .collection('harvest_stocks')
        .doc(harStock.stockId)
        .set(harStock.toMap(), options);
  }

  //delete harvest stocks
  Future<void> removeharStock(String stockId) {
    return _db.collection('harvest_stock').doc(stockId).delete();
  }

  //get feed stocks
  Stream<List<FeedStockModel>> getfeedstocks() {
    return _db
        .collection('feed_stocks')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) => snapshot
            .map((doc) => FeedStockModel.fromFirestore(doc.data()))
            .toList());
  }

  //add feeds
  Future<void> addfeedstocks(FeedStockModel feedStock) {
    var options = SetOptions(merge: true);
    return _db
        .collection('feed_stocks')
        .doc(feedStock.feedstockId)
        .set(feedStock.toMap(), options);
  }

//edit buyer
  Future<FeedStockModel> fectchfeed(String feedstockId) {
    return _db
        .collection('feed_stocks')
        .doc(feedstockId)
        .get()
        .then((snapshot) => FeedStockModel.fromFirestore(snapshot.data()));
  }

  //delete feed stocks
  Future<void> removefeedStock(String feedstockId) {
    return _db.collection('feed_stocks').doc(feedstockId).delete();
  }

  //get vitamins stocks
  Stream<List<VitaminStock>> getvitastocks() {
    return _db.collection('vitamin_stock').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => VitaminStock.fromJson(doc.data())).toList());
  }

  //add and update vitamin stocks
  Future<void> setvitastocks(VitaminStock vitaminStock) {
    var options = SetOptions(merge: true);
    return _db
        .collection('vitamin_stocks')
        .doc(vitaminStock.stockId)
        .set(vitaminStock.toMap(), options);
  }

  //delete vitamins stocks
  Future<void> removevitaStock(String stockId) {
    return _db.collection('vitamin_stock').doc(stockId).delete();
  }
}
