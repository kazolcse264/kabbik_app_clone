import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/audio_book.dart';

class Tab1ContentWidget extends StatelessWidget {
  const Tab1ContentWidget({
    super.key,
    required this.audioBook,
    this.index,
  });

  final AudioBookF audioBook;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ).w,
      child: Container(
        color: const Color(0x221622FF),
        //color: Colors.red,
        height: 50.h,
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/logo/free.svg',
              colorFilter: const ColorFilter.mode(
                Colors.green,
                BlendMode.srcIn,
              ),
              fit: BoxFit.fill,
              height: 35.w,
              width: 35.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                index == null  ? audioBook.title : audioBook.chapters.chapterNames[index!],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            const Icon(
              Icons.play_circle_filled_outlined,
              color: Colors.pink,
            ),
            SizedBox(width: 5.w),
            const Icon(
              Icons.arrow_circle_down_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}