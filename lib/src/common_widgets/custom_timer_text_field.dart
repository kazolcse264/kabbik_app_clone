import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/utils/global_functions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String labelText;
  final int minValue;
  final int maxValue;

  const CustomTextField({super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    this.minValue = 0,
    this.maxValue = 60,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.blue,
      focusNode: focusNode,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number, // Show numeric keyboard
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        hintText: '00',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      textAlign: TextAlign.left, // Align the text to the left
      //textAlignVertical: TextAlignVertical.center, // Vertically center the text
      onTap: () {
        // When clicked, move the cursor to the rightmost position
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          final intValue = int.tryParse(value);
          if (intValue == null || intValue < minValue || intValue > maxValue) {
            // If input is not in the allowed range, remove the last entered character
            controller.text = controller.text.substring(0, controller.text.length - 1);
          }
          if (controller.text.length == 2 && nextFocusNode != null && !nextFocusNode!.hasFocus) {
            nextFocusNode!.requestFocus();
          }
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          showErrorDialog(context, 'Please enter $labelText');
          return null;
        }
        final intValue = int.tryParse(value);
        if (intValue == null || intValue < minValue || intValue > maxValue) {
          showErrorDialog(context, 'Invalid $labelText');
          return '';
        }
        return null;
      },
    );
  }
}