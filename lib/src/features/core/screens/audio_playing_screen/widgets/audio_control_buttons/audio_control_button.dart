import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/audio_control_buttons/play_button.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/audio_control_buttons/previous_song_button.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/audio_control_buttons/repeat_button.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/audio_control_buttons/rewind_button.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/audio_control_buttons/suffle_button.dart';

import 'fast_forword_button.dart';
import 'next_song_button.dart';
class AudioControlButtonWidget extends StatelessWidget {
  final String id;
  final int currentPlaybackPosition;
  final Function(int) updateCurrentPlaybackPosition;
  final AudioHandler audioHandler;

  const AudioControlButtonWidget({
    Key? key,
    required this.id,
    required this.currentPlaybackPosition,
    required this.updateCurrentPlaybackPosition,
    required this.audioHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const RepeatButton(),
          const PreviousSongButton(),
          const RewindSongButton(),
          PlayButton(
            id: id,
            currentPlaybackPosition: currentPlaybackPosition,
            updateCurrentPlaybackPosition: updateCurrentPlaybackPosition,
            audioHandler: audioHandler,
          ),
          const FastForwardSongButton(),
          const NextSongButton(),
          const ShuffleButton(),
        ],
      ),
    );
  }
}