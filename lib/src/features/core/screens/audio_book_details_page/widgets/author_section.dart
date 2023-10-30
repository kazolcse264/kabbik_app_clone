import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/widgets/vertical_divider_section.dart';

import 'avater_stack_section.dart';

class AuthorSectionWidget extends StatelessWidget {
  const AuthorSectionWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ).w,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
            color: const Color(0x22250B89),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const AvatarStack(),
            SizedBox(width: 20.w),
            const VerticalDividerWidget(),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    title,
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '5 AudioBooks',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35.0.h),
              child: const Text(
                'More AudioBooks',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}