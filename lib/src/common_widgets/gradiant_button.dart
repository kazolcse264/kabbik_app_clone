import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GradientButton({super.key,
    required this.buttonText,
    required this.onPressed,
    this.gradientColors = const [Color(0xFF090301), Color(0xFF101B4B)],
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.stops = const [0, 0.7],
    this.borderRadius = 15,
    this.padding = const EdgeInsets.only(bottom: 5.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: const Color(0xFF29376A)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.57),
              blurRadius: 5,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent.withOpacity(0.38),
            disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
            shadowColor: Colors.transparent,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}