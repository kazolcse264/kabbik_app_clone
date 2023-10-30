import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/controllers/audio_book_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/global_functions.dart';

class PlayListButton extends StatelessWidget {
  const PlayListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioBookProvider>(
      builder: (context, musicProvider, child) {
        return IconButton(
          icon: const Icon(Icons.playlist_play, color: Colors.white),
          onPressed: () async {
            /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PlaylistSongScreen(),
                  ));*/
            showMsg(context, 'This section is not completed yet');
          },
        );
      },
    );
  }
}