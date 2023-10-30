import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;
  final bool isObscured;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
    this.isObscured = false,
    this.textInputAction,
    this.textInputType,
    this.autofillHints,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    widget.controller.addListener(onListen);
    _focusNode.addListener(onFocusChange);
    super.initState();
  }

  void onListen() => setState(() {});

  void onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    _focusNode.removeListener(onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        focusNode: _focusNode,
        keyboardType: widget.textInputType,
        autofillHints: widget.autofillHints,
        controller: widget.controller,
        cursorColor: kWhiteColor,
        obscureText: widget.isObscured,
        textInputAction: widget.textInputAction,
        style: const TextStyle(
          color: kWhiteColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.icon != null
              ? Icon(widget.icon)
              : const Icon(Icons.description),
          prefixIconColor: kWhiteColor,
          labelText: widget.label,
          labelStyle: TextStyle(
            color: kWhiteColor.withOpacity(0.8),
            fontSize: 16,
          ),
          suffixIcon: _focusNode.hasFocus && widget.controller.text.isNotEmpty
              ? IconButton(
            onPressed: () => widget.controller.clear(),
            icon: const Icon(
              Icons.cancel,
              color: kWhiteColor,
            ),
          )
              : null,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: kWhiteColor.withOpacity(0.5),
            fontSize: 14,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
                color: kWhiteColor,
                width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
                color: kWhiteColor,
                width: 1),
          ),
        ),
        validator: (value) {
          if (widget.textInputType == TextInputType.emailAddress) {
            if (value != null && !EmailValidator.validate(value)) {
              return 'Please enter a valid email';
            }
          } else {
            if (value == null || value.isEmpty) {
              return 'Please ${widget.hint}';
            }
          }
          return null;
        },
      ),
    );
  }
}

