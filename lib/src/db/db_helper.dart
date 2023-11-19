import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../constants/text_strings.dart';
import '../features/core/models/audio_book.dart';
import '../features/core/models/image_model.dart';
import '../features/core/models/user_model.dart';

class DbHelper {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUsers).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(collectionUsers).doc(userModel.userId);
    return doc.set(userModel.toMap());
  }
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String uid) =>
      _db.collection(collectionUsers).doc(uid).snapshots();

  static Future<void> updateUserProfileField(
      String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUsers).doc(uid).update(map);
  }

  static Future<QuerySnapshot> fetchAudioBooks() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionAudioBooks)
          .get();
      return querySnapshot;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching audio books: $error');
      }
      rethrow;
    }
  }

  static Future<void> addNewAudioBook(AudioBookF audioBookModel) {
    final wb = _db.batch(); //write batch
    final audioBookDoc = _db.collection(collectionAudioBooks).doc();
    audioBookModel.id = audioBookDoc.id;
    audioBookModel.thumbnailImageModel.audioBookCoverPageId = audioBookDoc.id;
    wb.set(audioBookDoc, audioBookModel.toMap());
    return wb.commit();
  }

  static Future<List<String>> getAllAudioBookImageUrlsByIsCarousel() async {
    try {
      final snapshot = await _db
          .collection(collectionAudioBooks)
          .where(
          '$audioBookFieldThumbnailImageModel.$imageFieldAudioBookIsCarousel',
          isEqualTo: 'true')
          .get();

      final imageUrls = snapshot.docs.map((doc) {
        final data = doc.data();
        final thumbnailImageModel = data[audioBookFieldThumbnailImageModel];
        final audioBookImageDownloadUrl =
        thumbnailImageModel[imageFieldAudioBookImageDownloadUrl] as String;
        return audioBookImageDownloadUrl;
      }).toList();
      return imageUrls;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching audio book image URLs by carousel: $error');
      }
      return []; // Return an empty list in case of an error
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllAudioBookCarousel() async {
    try {
      final snapshot = await _db
          .collection(collectionAudioBooks)
          .where(
          '$audioBookFieldThumbnailImageModel.$imageFieldAudioBookIsCarousel',
          isEqualTo: 'true')
          .get();
      return snapshot;
    } catch (error) {
      rethrow;
    }
  }
}