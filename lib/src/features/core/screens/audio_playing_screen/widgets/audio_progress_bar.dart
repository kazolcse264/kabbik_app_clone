import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/controllers/audio_book_controller.dart';
import 'package:provider/provider.dart';
import '../../../../../notifiers/progress_notifier.dart';
import '../../../../../services/page_manager.dart';
import '../../../../../services/service_locator.dart';

class AudioProgressBar extends StatelessWidget {
  final String id;
  final int currentPlaybackPosition;
  final Function(int) updateCurrentPlaybackPosition;

  const AudioProgressBar(
      {Key? key,
        required this.id,
        required this.currentPlaybackPosition,
        required this.updateCurrentPlaybackPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    final musicProvider = Provider.of<AudioBookProvider>(context, listen: false);
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: (Duration duration) {
            musicProvider.setPosition(id, duration.inSeconds);
            updateCurrentPlaybackPosition(duration.inSeconds);
            pageManager.seek(duration);
          },
          progressBarColor: Colors.white,
          thumbColor: Colors.white,
          baseBarColor: Colors.grey,
          bufferedBarColor: Colors.white38,
          timeLabelTextStyle: const TextStyle(
            color: Colors.white,
          ),
          timeLabelPadding: 5.0,
        );
      },
    );
  }
}