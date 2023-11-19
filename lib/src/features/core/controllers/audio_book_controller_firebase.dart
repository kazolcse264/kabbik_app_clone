import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/text_strings.dart';

import '../../../db/db_helper.dart';
import '../models/audio_book.dart';

import '../models/image_model.dart';


class AudioBooksProviderFirebase with ChangeNotifier {
  List<AudioBookF> _audioBooksF = [];
  List<AudioBookF> _audioBooksCarousel = [];
  List<AudioBookF> get audioBooksF => _audioBooksF;
  List<AudioBookF> get audioBooksCarousel => _audioBooksCarousel;

  late Reference imageRef;

  // Fetch audio books from Firestore
  Future<void> fetchAudioBooks() async {
    try{
      final querySnapshot =  await DbHelper.fetchAudioBooks();
      _audioBooksF = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return AudioBookF.fromMap({
          'id': doc.id,
          'album': data['album'] ?? '',
          'title': data['title'] ?? '',
          'thumbnailImageModel': data['thumbnailImageModel'] ?? '',
          'url': data['url'] ?? '',
          'chapters': data['chapters'] ?? {},
          'description': data['description'] ?? '',
        });
      }).toList();
      notifyListeners();
    }
    catch (error) {
      if (kDebugMode) {
        print('Error fetching audio books: $error');
      }
    }
  }


  AudioBookF getAudioBookByArtUri(Uri uri) {
    return _audioBooksF.firstWhere((audioBook) => audioBook.thumbnailImageModel.audioBookImageDownloadUrl == uri.toString());
  }
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

  Future<String> uploadAudio(
      {required String path,
      required String audioFileName,
      String? mainAudioFileName,
      int? count}) async {
    /* final audioFileDir = count == null
        ? firebaseStorageAudioBookAudioFileDir
        : '$firebaseStorageAudioBookAudioFileDir/$count';*/
    final audioFileNameWithExtension =
        '$audioFileName.mp3'; // Modify the extension as needed

    if (count == null) {
      imageRef = FirebaseStorage.instance.ref().child(
          '$firebaseStorageAudioBookAudioFileDir/$audioFileName/$audioFileNameWithExtension');
    } else {
      imageRef = FirebaseStorage.instance.ref().child(
          '$firebaseStorageAudioBookAudioFileDir/$mainAudioFileName/$count/$audioFileNameWithExtension');
    }

/*    final imageRef = FirebaseStorage.instance
        .ref()
        .child('$audioFileDir/$audioFileNameWithExtension');*/
    final uploadTask = imageRef.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addNewAudioBook(AudioBookF audioBookModel) async {
    return await DbHelper.addNewAudioBook(audioBookModel);
  }

  Future<List<String>> getAllAudioBookImageUrlsByIsCarousel() async {
   return await DbHelper.getAllAudioBookImageUrlsByIsCarousel();
  }
  Future<void> getAllAudioBookCarousel() async {
    try {
      final snapshot = await DbHelper.getAllAudioBookCarousel();
      _audioBooksCarousel = snapshot.docs.map((doc) {
        final data = doc.data();
        return AudioBookF.fromMap({
          'id': doc.id,
          'album': data['album'] ?? '',
          'title': data['title'] ?? '',
          'thumbnailImageModel': data['thumbnailImageModel'] ?? '',
          'url': data['url'] ?? '',
          'chapters': data['chapters'] ?? {},
          'description': data['description'] ?? '',
        });
      }).toList();
     notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching audio book image URLs by carousel: $error');
      }
    }
  }

}
