const String imageFieldAudioBookCoverPageId = 'audioBookCoverPageId';
const String imageFieldAudioBookCoverTitle = 'audioBookCoverTitle';
const String imageFieldAudioBookImageDownloadUrl = 'audioBookImageDownloadUrl';
const String imageFieldAudioBookIsCarousel = 'audioBookIsCarousel';

class ImageModel {
  String? audioBookCoverPageId;
  String audioBookCoverTitle;
  String audioBookImageDownloadUrl;
  String audioBookIsCarousel;

  ImageModel({
    this.audioBookCoverPageId,
    required this.audioBookCoverTitle,
    required this.audioBookImageDownloadUrl,
    required this.audioBookIsCarousel,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    imageFieldAudioBookCoverPageId: audioBookCoverPageId,
    imageFieldAudioBookCoverTitle: audioBookCoverTitle,
    imageFieldAudioBookImageDownloadUrl: audioBookImageDownloadUrl,
    imageFieldAudioBookIsCarousel : audioBookIsCarousel,
  };

  factory ImageModel.fromMap(Map<String, dynamic> map) => ImageModel(
    audioBookCoverPageId: map[imageFieldAudioBookCoverPageId],
    audioBookCoverTitle: map[imageFieldAudioBookCoverTitle],
    audioBookImageDownloadUrl: map[imageFieldAudioBookImageDownloadUrl],
    audioBookIsCarousel: map[imageFieldAudioBookIsCarousel],
  );

  @override
  String toString() {
    return 'ImageModel{audioBookCoverPageId: $audioBookCoverPageId, audioBookCoverTitle: $audioBookCoverTitle, audioBookImageDownloadUrl: $audioBookImageDownloadUrl, audioBookIsCarousel: $audioBookIsCarousel}';
  }
}
