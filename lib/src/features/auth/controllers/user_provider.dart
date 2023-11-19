
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../constants/text_strings.dart';
import '../../../db/db_helper.dart';
import '../../core/models/image_model.dart';
import '../../core/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;

  Future<void> addUser(UserModel userModel) => DbHelper.addUser(userModel);

  Future<bool> doesUserExist(String uid) => DbHelper.doesUserExist(uid);

  getUserInfo() {
    DbHelper.getUserInfo(FirebaseAuth.instance.currentUser!.uid).listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }
  Future<void> updateUserProfileField(String field, dynamic value) =>
      DbHelper.updateUserProfileField(
        FirebaseAuth.instance.currentUser!.uid,
        {field : value},
      );

  Future<ImageModel> uploadImage(
      String path, String titleName, String isCarousel) async {
    final imageRef = FirebaseStorage.instance
        .ref()
        .child('$firebaseStorageAudioBookImageDir/$titleName');
    final uploadTask = imageRef.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return ImageModel(
        audioBookCoverTitle: titleName,
        audioBookImageDownloadUrl: downloadUrl,
        audioBookIsCarousel: isCarousel);
  }
}