import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingWidget extends StatelessWidget {
  final double? count;

  const RatingWidget({
    Key? key,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (count == null) ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        RatingBar.builder(
          initialRating: count ?? 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          unratedColor: Colors.grey,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // Handle rating update if needed
          },

        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          (count == null) ? 'RATE NOW' : 'Rating: ${count.toString()}',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}