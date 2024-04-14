import 'package:flutter/material.dart';

Widget textWidget({
  required String text,
  required TextStyle style,
  var textAlign,
}) {
  return Text(
    text,
    style: style,
    textAlign: textAlign,
  );
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    required this.style,
    required this.textAlign,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
