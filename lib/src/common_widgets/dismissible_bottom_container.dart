import 'package:flutter/material.dart';

import '../features/core/screens/audio_book_details_page/imports.dart';
import 'home_audio_progress_bar.dart';

class DismissibleBottomContainer extends StatefulWidget {
  const DismissibleBottomContainer({Key? key}) : super(key: key);

  @override
  State<DismissibleBottomContainer> createState() =>
      _DismissibleBottomContainerState();
}

class _DismissibleBottomContainerState
    extends State<DismissibleBottomContainer> {
  bool showPlayingSection = true;
  final audioHandler = getIt<AudioHandler>();
  int? currentPlaybackPosition;

  void updateCurrentPlaybackPosition(int position) {
    setState(() {
      currentPlaybackPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<MediaItem?>(
      valueListenable: pageManager.currentSongPlayingNotifier,
      builder: (_, mediaItem, __) {
        showPlayingSection = mediaItem != null;
        return showPlayingSection
            ? Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.none,
                onDismissed: (direction) {
                  // You can add code to handle the dismissal here
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.3, 1],
                      colors: [Color(0xFF05011C), Color(0xFF0A057D)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    //height:120,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Playing :  ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const CurrentSongTitle(
                              textSize: 16,
                              textColor: Colors.white,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                               // pageManager.currentSongTitleNotifier.value = '';
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        HomeAudioProgressBar(
                          id: mediaItem!.id,
                          updateCurrentPlaybackPosition:
                              updateCurrentPlaybackPosition,
                        ),
                        AudioControlButtonWidget(
                          id: mediaItem.id,
                          currentPlaybackPosition: currentPlaybackPosition ?? 0,
                          updateCurrentPlaybackPosition:
                              updateCurrentPlaybackPosition,
                          audioHandler: audioHandler,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
