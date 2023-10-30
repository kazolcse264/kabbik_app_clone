
import 'package:audio_service/audio_service.dart';
import 'package:kabbik_ui_clone/src/services/page_manager.dart';

import '../../../../../utils/global_functions.dart';
import '../../../models/audio_book.dart';


Future<void> createAndAddMediaItem({
  required AudioBookF audioBook,
  required PageManager pageManager,
  required AudioHandler audioHandler,
}) async {
  //File imageFile = await getImageFileFromAssets(audioBook.thumbnailImageModel.audioBookImageDownloadUrl);
  if (audioBook.chapters.chapterUrls.isEmpty) {
    clearQueue(audioHandler);
    final newMediaItem = MediaItem(
      id: audioBook.id ?? '',
      title: audioBook.title,
      album: audioBook.album,
      extras: {
        'url': audioBook.url,
        'isFile': true,
      },
      artUri: Uri.parse(audioBook.thumbnailImageModel.audioBookImageDownloadUrl),
    );

    audioHandler.addQueueItem(newMediaItem);
  } else {
    clearQueue(audioHandler);
    List<String> allChapterUrls = audioBook.chapters.chapterUrls;
    List<String> allChapterNames = audioBook.chapters.chapterNames;
    for (int index = 0; index < allChapterUrls.length; index++) {
      final newMediaItem = MediaItem(
        id: '${audioBook.id}_${index + 1}',
        title: allChapterNames[index],
        album: audioBook.album,
        extras: {
          'url': allChapterUrls[index],
          'isFile': true,
        },
        artUri: Uri.parse(audioBook.thumbnailImageModel.audioBookImageDownloadUrl),
      );
      audioHandler.addQueueItem(newMediaItem);
    }
  }
}
