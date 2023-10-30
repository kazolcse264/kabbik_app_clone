import 'package:flutter/material.dart';

class SleepTimerOptionItem extends StatelessWidget {
  final String optionText;
  final int? optionValue;

  const SleepTimerOptionItem({super.key,
    required this.optionText,
    required this.optionValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      color: const Color(0xFF0A1E3C),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Text(
          optionText,
          style: TextStyle(
            color: optionValue != 0 ? Colors.white : Colors.yellowAccent,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}