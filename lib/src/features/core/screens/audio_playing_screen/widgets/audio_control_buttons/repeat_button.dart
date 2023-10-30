import 'package:flutter/material.dart';

import '../../../../../../notifiers/repeat_button_notifier.dart';
import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(Icons.repeat, color: Colors.white);
            break;
          case RepeatState.repeatSong:
            icon = const Icon(Icons.repeat_one, color: Colors.grey);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat, color: Colors.blueGrey);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}