import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../features/core/models/audio_book.dart';

class SmoothPageIndicatorWidget extends StatelessWidget {
  final PageController pageController;
  final List<AudioBookF> audioBookCarouselList;
  const SmoothPageIndicatorWidget({
    super.key,
    required this.pageController,
    required this.audioBookCarouselList,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: audioBookCarouselList.length,
      effect:  WormEffect(
        dotHeight: 10.w,
        dotWidth: 10.w,
      ),
    );
  }
}