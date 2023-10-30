import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionSectionWidget extends StatelessWidget {
  const DescriptionSectionWidget({
    super.key,
    required this.description,
  });

  final String  description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ReadMoreText(
        description,
        trimLines: 2,
        style: const TextStyle(color: Colors.white),
        colorClickableText: Colors.blue,
        trimMode: TrimMode.Line,
        textAlign: TextAlign.justify,
        trimCollapsedText: '...Read more',
        trimExpandedText: ' Less',
      ),
    );
  }
}