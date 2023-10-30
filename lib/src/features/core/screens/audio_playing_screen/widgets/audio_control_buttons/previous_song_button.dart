import 'package:flutter/material.dart';

import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon:  Icon(
            Icons.skip_previous,
            color: (isFirst) ? Colors.grey :Colors.white,
          ),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}