import 'package:flutter/material.dart';

import '../constants/text_strings.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.action = kSeeMore,
  }) : super(key: key);

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: kBangla,
              ),
        ),
        Text(
          action,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                //fontFamily: bangla,
              ),
        ),
      ],
    );
  }
}
