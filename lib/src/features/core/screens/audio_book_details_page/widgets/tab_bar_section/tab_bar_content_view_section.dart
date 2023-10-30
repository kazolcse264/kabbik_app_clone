import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/widgets/rating_section.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/widgets/tab_bar_section/tab1_content.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/widgets/vertical_divider_section.dart';

import '../avater_stack_section.dart';

class TabBarContentView extends StatelessWidget {
  final TabController tabController;
  final AudioBookF audioBook;

  const TabBarContentView({super.key,
    required this.tabController,
    required this.audioBook,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: TabBarView(
        controller: tabController,
        children: [
          _buildTab1Content(),
          _buildTab2Content(),
          _buildTab3Content(),
        ],
      ),
    );
  }

  Widget _buildTab1Content() {
    return (audioBook.chapters.chapterNames.isNotEmpty) ? ListView.builder(
      itemCount: audioBook.chapters.chapterNames.length,
      itemBuilder: (context, index) {
        return Tab1ContentWidget(audioBook: audioBook,index: index,);
      },
    ):
    ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Tab1ContentWidget(audioBook: audioBook,);
      },
    );
    //Tab1ContentWidget(audioBook: audioBook);
  }

  Widget _buildTab2Content() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ).w,
          child: _buildTab2Item(),
        );
      },
    );
  }

  Widget _buildTab2Item() {
    return Container(
      color: const Color(0x221622FF),
      height: 100.h,
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
                Text(
                  audioBook.title,
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
    );
  }
/*Widget _buildTab3Content() {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 500.h,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10.0).w,
                  child: _buildReviewButton(),
                ),
              ),
              ListView.builder(
                itemCount: 10,
                //shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ).w,
                    child: _buildTab3Item(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  Widget _buildTab3Content() {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 500.h,
        child: ListView.builder(
          itemCount: 11, // 1 for the review button + 10 for items
          itemBuilder: (context, index) {
            if (index == 0) {
              // First item is the review button
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10.0).w,
                  child: _buildReviewButton(),
                ),
              );
            } else {
              // Items 1 to 10 are the individual items
              return Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ).w,
                child: _buildTab3Item(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildReviewButton() {
    return Container(
      height: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient:  LinearGradient(
          colors: [Colors.red, Colors.red.shade200],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.8, 1],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: const Center(
        child: Text(
          'ADD REVIEW',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTab3Item() {
    return Container(
      color: const Color(0x221622FF),
      height: 100.h,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage('assets/images/humayun_ahmed.jpg'),
            radius: 31.r,
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  audioBook.album,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                const RatingWidget(count: 5.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0).h,
            child: const Text(
              '17/08/2023',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


