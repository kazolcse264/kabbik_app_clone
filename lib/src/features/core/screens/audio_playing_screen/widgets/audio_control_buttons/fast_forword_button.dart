import 'package:flutter/material.dart';

import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';

class FastForwardSongButton extends StatelessWidget {
  const FastForwardSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.fastForwardSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon:  const Icon(Icons.forward_10, color: Colors.white),
          onPressed: pageManager.fastForward,
        );
      },
    );
  }
}