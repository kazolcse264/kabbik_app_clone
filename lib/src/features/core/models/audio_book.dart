import 'audio_book_chapter.dart';
import 'image_model.dart';


const String audioBookFieldThumbnailImageModel = 'thumbnailImageModel';

class AudioBookF {
  String? id;
  final String album;
  final String title;
  ImageModel thumbnailImageModel;
  final String url;
  AudioBookChapter chapters;
  final String description;

  AudioBookF({
    this.id,
    required this.album,
    required this.title,
    required this.thumbnailImageModel,
    required this.url,
    required this.chapters,
    required this.description,
  });

  factory AudioBookF.fromMap(Map<String, dynamic> map) {
    return AudioBookF(
      id: map['id'],
      album: map['album'],
      title: map['title'],
      thumbnailImageModel: ImageModel.fromMap(map[audioBookFieldThumbnailImageModel]),
      url: map['url'],
      chapters: AudioBookChapter.fromMap(map['chapters'] ?? {}),
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'album': album,
      'title': title,
      audioBookFieldThumbnailImageModel: thumbnailImageModel.toMap(),
      'url': url,
      'chapters': chapters.toMap(),
      'description': description,
    };
  }

  @override
  String toString() {
    return 'AudioBookF{id: $id, album: $album, title: $title, thumbnailImageModel: $thumbnailImageModel, url: $url, chapters: $chapters, description: $description}';
  }
}
