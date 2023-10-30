
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/details_page.dart';

import '../features/core/screens/audio_book_details_page/imports.dart';
import '../features/core/screens/dashboard/methods/media_item_creation.dart';

class AutoPlayPageView extends StatefulWidget {
  final double height;
  final PageController pageController;
  final int initialIndex;
  final List<AudioBookF> audioBookCarouselList;
  const AutoPlayPageView({super.key,
    required this.height,
    required this.pageController,
    required this.initialIndex,
    required this.audioBookCarouselList,
  });
  @override
  State<AutoPlayPageView> createState() => _AutoPlayPageViewState();
}

class _AutoPlayPageViewState extends State<AutoPlayPageView> {
  int _currentIndex = 0;
  bool _autoPlayForward = true;
  late Timer _timer;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _startAutoPlay();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_autoPlayForward) {
        if (_currentIndex < widget.audioBookCarouselList.length - 1) {
          widget.pageController.animateToPage(_currentIndex + 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        } else {
          _autoPlayForward = false;
          widget.pageController.animateToPage(_currentIndex - 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        }
      } else {
        if (_currentIndex > 0) {
          widget.pageController.animateToPage(_currentIndex - 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        } else {
          _autoPlayForward = true;
          widget.pageController.animateToPage(_currentIndex + 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    final audioHandler = getIt<AudioHandler>();
    return SizedBox(
      height: widget.height, // Customize the height as needed
      child: PageView(
        controller: widget.pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children:  widget.audioBookCarouselList.map((audioBook) {
          return InkWell(
            onTap: (){
              createAndAddMediaItem(
                audioBook: audioBook,
                pageManager: pageManager,
                audioHandler: audioHandler,
              );
              Navigator.of(context).pushNamed(DetailsPage.routeName,arguments: audioBook);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                decoration: BoxDecoration(
                 /* border: Border.all(color:  const Color(0xFFFFFFFF),),
                  borderRadius: BorderRadiusDirectional.circular(20),*/
                  image: DecorationImage(
                    image: NetworkImage(audioBook.thumbnailImageModel.audioBookImageDownloadUrl),
                    fit: BoxFit.contain,

                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

