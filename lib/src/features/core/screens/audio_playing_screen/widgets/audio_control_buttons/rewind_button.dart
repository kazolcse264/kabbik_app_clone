import 'package:flutter/material.dart';

import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';

class RewindSongButton extends StatelessWidget {
  const RewindSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.rewindSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: const Icon(Icons.replay_10, color: Colors.white),
          onPressed: pageManager.rewind,
        );
      },
    );
  }
}