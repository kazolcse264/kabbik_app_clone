
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common_widgets/auto_play_page_view.dart';
import '../../../models/audio_book.dart';


class MainCarouselSliderWidget extends StatelessWidget {
  const MainCarouselSliderWidget({
    super.key,
    required PageController pageController1,

    required this.audioBookCarouselList,
  }) : _pageController1 = pageController1;

  final PageController _pageController1;
  final List<AudioBookF> audioBookCarouselList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Stack(
        //fit: StackFit.loose,
        children: [
          buildCarouselSliderTop(
            height: 400.h,
            pageController: _pageController1,
            audioBookCarouselList: audioBookCarouselList,
          ),

          ///For creating filter on the slider
          //const Positioned.fill(child: BackgroundFilter()),
        ],
      ),
    );
  }

  AutoPlayPageView buildCarouselSliderTop({
    required double height,
    required PageController pageController,
    required List<AudioBookF> audioBookCarouselList,
  }) {
    return AutoPlayPageView(
      height: height,
      pageController: pageController,
      initialIndex: 0,
      audioBookCarouselList: audioBookCarouselList,
    );
  }
}
