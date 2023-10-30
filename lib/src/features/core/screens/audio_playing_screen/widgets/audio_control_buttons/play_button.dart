import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/controllers/audio_book_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../notifiers/play_button_notifier.dart';
import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';

class PlayButton extends StatelessWidget {
  final String id;
  final int currentPlaybackPosition;
  final Function(int) updateCurrentPlaybackPosition;
  final AudioHandler audioHandler;

  const PlayButton({
    Key? key,
    required this.id,
    required this.currentPlaybackPosition,
    required this.updateCurrentPlaybackPosition,
    required this.audioHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    final audioBookProvider = Provider.of<AudioBookProvider>(context, listen: false);

    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              iconSize: 32.0,
              onPressed: () {
                pageManager.play();
                resumePlayback(
                    pageManager, id, currentPlaybackPosition);
              },
              //onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause, color: Colors.white),
              iconSize: 32.0,
              onPressed: () {
                pageManager.pause();
                stopPlayback(audioHandler, id, audioBookProvider);
              },
              //onPressed: pageManager.pause,
            );
        }
      },
    );
  }

  void resumePlayback(PageManager singleSongPageManager, String id,
      int? currentPlaybackPosition) {
    final currentPosition = currentPlaybackPosition ?? 0;
    singleSongPageManager.seek(Duration(seconds: currentPosition));
    singleSongPageManager.play();
  }

  void stopPlayback(
      AudioHandler singleAudioHandler, String id, AudioBookProvider audioBookProvider) {
    singleAudioHandler.playbackState.listen((state) {
      if (state.processingState == AudioProcessingState.ready) {
        final currentPosition = state.position.inSeconds;
        if (currentPosition > 0) {
          audioBookProvider.setPosition(id, currentPosition);
        }
      }
    });
    updateCurrentPlaybackPosition(audioBookProvider.getPosition(id) ??
        0); // Cancel the subscription after the first update
  }
}