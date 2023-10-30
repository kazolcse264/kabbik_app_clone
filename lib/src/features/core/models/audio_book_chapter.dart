class AudioBookChapter {
  final List<String> chapterNames;
  final List<String> chapterUrls;

  AudioBookChapter({
    required this.chapterNames,
    required this.chapterUrls,
  });

  factory AudioBookChapter.fromMap(Map<String, dynamic> map) {
    return AudioBookChapter(
      chapterNames: List<String>.from(map['chapterNames'] ?? []),
      chapterUrls: List<String>.from(map['chapterUrls'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chapterNames': chapterNames,
      'chapterUrls': chapterUrls,
    };
  }

  @override
  String toString() {
    return 'AudioBookChapter{chapterNames: $chapterNames, chapterUrls: $chapterUrls}';
  }
}
