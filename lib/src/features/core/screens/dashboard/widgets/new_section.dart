import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';

import '../../../../../common_widgets/audioBook_card.dart';

class NewSectionWidget extends StatelessWidget {
  const NewSectionWidget({
    super.key,
    required this.audioBookList,
  });

  final List<AudioBookF> audioBookList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 0.40.sh,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: audioBookList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                AudioBookCard(
                  audioBook: audioBookList[index],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(audioBookList[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(audioBookList[index].album,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}