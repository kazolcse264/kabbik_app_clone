import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common_widgets/rating_card.dart';

class ListeningWidget extends StatelessWidget {
  const ListeningWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const RatingCard(
          labelText: '1645',
          icon: Icons.headset,
        ),
        SizedBox(
          width: 80.w,
        ),
        const RatingCard(
          labelText: '5.0',
          icon: Icons.star_sharp,
        ),
      ],
    );
  }
}