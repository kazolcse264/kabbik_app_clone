import 'package:flutter/material.dart';

import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon:  Icon(
            Icons.skip_next,
            color: (isLast) ? Colors.grey : Colors.white,
          ),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}