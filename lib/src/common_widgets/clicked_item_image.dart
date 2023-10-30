
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClickedItemImageWidget extends StatelessWidget {
  const ClickedItemImageWidget({
    super.key,
    required this.artUri,
  });

  final String artUri;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.w,
        height: 320.h,
        child: Image.network(artUri, fit: BoxFit.contain),
      ),
    );
  }
}

/*

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClickedItemImageWidget extends StatefulWidget {
  const ClickedItemImageWidget({
    super.key,
    required this.artUri,
  });

  final String artUri;

  @override
  State<ClickedItemImageWidget> createState() => _ClickedItemImageWidgetState();
}

class _ClickedItemImageWidgetState extends State<ClickedItemImageWidget> with TickerProviderStateMixin{
  late AnimationController _controller1;
  late AnimationController _controller2;
  double rotationAngle = 0.45 * pi; // Starting angle
  double rotationAngle2 = 0.0; // Starting angle

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(seconds: 3), // Set the duration of the transition
      vsync: this,

    );
    _controller2 = AnimationController(
      duration:   Duration(milliseconds: (2.5 * 1000).toInt()), // Set the duration of the transition
      vsync: this,
    );
    final curvedController1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    );
    final curvedController2 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.fastOutSlowIn,
    );

    _controller1.forward(); // Start the animation automatically
    _controller2.forward(); // Start the animation automatically

    curvedController1.addListener(() {
      setState(() {
        rotationAngle = 0.45 * pi - (curvedController1.value * 0.45 * pi); // Reverse the angle

      });
    });
    curvedController2.addListener(() {
      setState(() {
        rotationAngle2 = (curvedController2.value * 0.5 * pi);// Rotate from 0 to 90 degrees // Reverse the angle
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 320.0,
        child: Stack(
          children: [
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationAngle), // Rotate from start to end angle
              child: Image.asset(widget.artUri, fit: BoxFit.contain),
            ),
            Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-rotationAngle2), // Rotate from start to end angle
              child: Image.asset(widget.artUri, fit: BoxFit.contain),
            ),


          ],
        ),
      ),
    );
  }
}
*/
