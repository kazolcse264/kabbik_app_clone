import 'package:flutter/material.dart';

import '../../../../../services/page_manager.dart';
import '../../../../../services/service_locator.dart';

class CurrentSongTitle extends StatelessWidget {
  final double? textSize;
  final Color? textColor;

  const CurrentSongTitle({
    Key? key,
     this.textSize,
     this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Text(
          title,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
        );
      },
    );
  }
}
