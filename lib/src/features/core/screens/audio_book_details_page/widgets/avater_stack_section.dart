import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 33.r,
        ),
        CircleAvatar(
          backgroundImage: const AssetImage('assets/logo/writer.png'),
          radius: 31.r,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          width: 62.w,
          height: 62.w,
        ),
        Positioned(
          left: 50.w,
          top: 40.w,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
              Border.all(color: Colors.green, width: 2), // Add white border
            ),
            child:  CircleAvatar(
              backgroundImage: const AssetImage(
                'assets/logo/writer.png',
              ),
              radius: 10.r,
            ),
          ),
        ),
      ],
    );
  }
}