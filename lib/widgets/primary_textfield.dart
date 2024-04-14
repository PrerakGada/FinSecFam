import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.borderColor,
    this.isObscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Color? borderColor;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
