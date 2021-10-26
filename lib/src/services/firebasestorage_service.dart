import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStoreService {
  final storage = FirebaseStorage.instance;

  Future<String> uploadCustomerImage(File file, String fileName) async {
    var snapshot =
        await storage.ref().child('customerImages/$fileName').putFile(file);

    return await snapshot.ref.getDownloadURL();
  }
}
