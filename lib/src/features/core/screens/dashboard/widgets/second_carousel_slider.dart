
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common_widgets/auto_play_page_view.dart';
import '../../../../../common_widgets/smooth_page_indicator.dart';
import '../../../models/audio_book.dart';

class SecondCarouselSliderWidget extends StatelessWidget {
  const SecondCarouselSliderWidget({
    super.key,
    required PageController pageController2,
    required  this.audioBookCarouselList,
  }) : _pageController2 = pageController2;

  final PageController _pageController2;
  final List<AudioBookF> audioBookCarouselList;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: buildCarouselSliderBeforeNewSection(
              height: 180.h,
              pageController: _pageController2,
            audioBookCarouselList: audioBookCarouselList,),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 30.h,
          child: Center(
            child: SmoothPageIndicatorWidget(
              pageController: _pageController2,
             audioBookCarouselList: audioBookCarouselList,
            ),
          ),
        ),
      ],
    );
  }

  AutoPlayPageView buildCarouselSliderBeforeNewSection({
    required double height,
    required PageController pageController,
    required List<AudioBookF> audioBookCarouselList,
  }) {
    return AutoPlayPageView(
      height: height,
      pageController: pageController,
      audioBookCarouselList: audioBookCarouselList,
      initialIndex: 0,
    );
  }
}