import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weigh_master_admin/Data/Model/productModel.dart';

class DbService with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  Uint8List? imageBytes;
  bool processingImage = false;
  FirebaseStorage fs = FirebaseStorage.instance;
  SettableMetadata metadata = SettableMetadata(contentType: "image/jpeg");
  final now = DateTime.now();
  Blob? blob;
  String? imageurl;
  pickImageinWeb() {
    print("In");
    SettableMetadata metadata = SettableMetadata(contentType: "image/jpeg");
    // processingImage = true;
    notifyListeners();
    FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';

    input.click();

    input.onChange.listen((event) {
      final file = input.files?.first;
      if (file != null) {
        final reader = FileReader();

        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((event) async {
          Uint8List data = Uint8List.fromList(reader.result as List<int>);

          imageBytes = data;

          blob = Blob(data);
          // processingImage = false;
          notifyListeners();
          try {
             print("1111111111111111111");
            final now = DateTime.now();
            var snapshot = await fs
                .ref()
                .child("productImage/$now")
                .putBlob(blob, metadata);
 print("2222222222222222");
            String downloadUrl = await snapshot.ref.getDownloadURL();
 print("33333333333333333333");
            imageurl = downloadUrl;
            print("=====${imageurl}====");
            print(downloadUrl);
          } catch (error) {
            print('Error uploading image to Firebase Storage: $error');
          }
        });
      }
    });
  }

  Future storeProduct(ProductModel productModel) async {
    final doc = db.collection("Product Data").doc();

    doc.set(productModel.toHson(doc.id));
  }

  // File? fileImage;
  // pickeImage() async {
  //   final imagePicker = ImagePicker();
  //   final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     fileImage = File(pickedFile.path);
  //   }
  // }
}
