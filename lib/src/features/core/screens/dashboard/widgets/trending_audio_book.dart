

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';

import '../../../../../common_widgets/audioBook_card.dart';
import '../../../../../common_widgets/section_header.dart';

class TrendingAudioBook extends StatelessWidget {
  const TrendingAudioBook({
    Key? key,
    required this.audioBookListF,
  }) : super(key: key);

  final List<AudioBookF> audioBookListF;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        bottom: 8.0,
      ).w,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0).w,
            child: const SectionHeader(title: 'Trending'),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 0.27.sh,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: audioBookListF.length,
              itemBuilder: (context, index) {
                return AudioBookCard(audioBook: audioBookListF[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}