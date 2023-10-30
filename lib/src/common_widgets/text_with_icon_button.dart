import 'package:flutter/material.dart';

class TextWithIconButtonWidget extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final List<Color> colorList;
  final bool isVertical;
  final VoidCallback onPressed;

  const TextWithIconButtonWidget({super.key,
    required this.icon,
    required this.labelText,
    required this.colorList,
    required this.isVertical,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 38,
        width: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colorList,
            begin: isVertical ? Alignment.topCenter : Alignment.centerLeft,
            end: isVertical ? Alignment.bottomCenter : Alignment.centerRight,
            stops: const [0.2, 0.9],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              labelText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
