import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../constants/colors.dart';
import 'bottom_sheet_playlist.dart';

class PlayListSectionWidget extends StatelessWidget {
  const PlayListSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: buildPlaylistInkWell(context),
    );
  }

  // Function to build the InkWell
  InkWell buildPlaylistInkWell(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: kPlayListBottomSheetBGColor,
          isScrollControlled: true,
          builder: (context) => buildPlaylistBottomSheet(context),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0.w),
        child: Container(
          height: 50.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Color(0xFF0C1E3C),
          ),
          child: buildPlaylistRow(),
        ),
      ),
    );
  }

// Function to build the bottom sheet
  Widget buildPlaylistBottomSheet(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildBottomSheetHeader(context),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final maxHeight = MediaQuery.of(context).size.height * 0.8; // Adjust this factor as needed
              final availableHeight = constraints.maxHeight - 80.0; // Adjust header height
              final contentHeight = availableHeight.clamp(80.0, maxHeight);

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: contentHeight, // Include header height
                    minHeight: 80.0,
                  ),
                  child: const Playlist(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  // Function to build bottom sheet header
  Column buildBottomSheetHeader(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'PlayList',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
            ),
          ),
        ),
      ],
    );
  }

// Function to build the row inside the container
  Row buildPlaylistRow() {
    return Row(
      children: [
        SizedBox(width: 10.w),
        const Icon(
          Icons.playlist_add_check,
          color: Colors.white,
        ),
        SizedBox(width: 10.w),
        Text(
          'Playlist',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
