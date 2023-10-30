import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ItemClickedTitleAlbumWidget extends StatelessWidget {
  const ItemClickedTitleAlbumWidget({
    super.key,
    required this.title,
    required this.album,

  });

  final String  title;
  final String  album;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style:  TextStyle(
            fontSize: 25.sp,
            color: Colors.white,
          ),
        ),
        Text(
          album,
          style:  TextStyle(
            fontSize: 16.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}