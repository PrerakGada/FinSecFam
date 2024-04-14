import 'package:flutter/material.dart';

import 'text_style.dart' as typography;

class Txt extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  const Txt(
    this.text, {
    super.key,
    required this.style,
    this.textAlign = TextAlign.start,
  });

  // Static methods for each style
  static Widget title(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.title(),
        textAlign: textAlign,
      );

  static Widget smallTitle(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.smallTitle(),
        textAlign: textAlign,
      );

  static Widget textField(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    var color,
  }) =>
      Txt(
        text,
        style: typography.textField(color: color),
        textAlign: textAlign,
      );

  static Widget hintField(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.hintField(),
        textAlign: textAlign,
      );

  static Widget buttonLarge(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.buttonLarge(),
        textAlign: textAlign,
      );

  static Widget buttonSmall(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.buttonSmall(),
        textAlign: textAlign,
      );

  static Widget descp(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.descp(),
        textAlign: textAlign,
      );

  static Widget smallDescp2(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.smallDescp2(),
        textAlign: textAlign,
      );

  static Widget smallDescp(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    var color,
  }) =>
      Txt(
        text,
        style: typography.smallDescp(color: color),
        textAlign: textAlign,
      );

  static Widget smallTitle2(String text,
          {Key? key, TextAlign textAlign = TextAlign.start}) =>
      Txt(
        text,
        style: typography.smallTitle2(),
        textAlign: textAlign,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: key,
      style: style,
      textAlign: textAlign,
    );
  }
}
