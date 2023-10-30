import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/sleep_timer_section/sleep_timer_option_item.dart';

import '../../../../../../constants/text_strings.dart';

class SleepTimerOptions extends StatelessWidget {
  const SleepTimerOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxHeight = MediaQuery.of(context).size.height * 0.45;
        final availableHeight = constraints.maxHeight - 80.0;
        final contentHeight = availableHeight.clamp(80.0, maxHeight);
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: contentHeight,
              minHeight: 80.0,
            ),
            child: ListView.separated(
              itemCount: kSleepTimerMap.length,
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: const Color(0xFF1D2B41),
              ),
              itemBuilder: (context, index) {
                final optionText = kSleepTimerMap.keys.elementAt(index);
                final optionValue = kSleepTimerMap[optionText];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop(optionValue);
                  },
                  child: SleepTimerOptionItem(
                    optionText: optionText,
                    optionValue: optionValue,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}