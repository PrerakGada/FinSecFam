import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import '../../utils/size_config.dart';

TextStyle title() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(5.5),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );
}

TextStyle smallTitle() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(5.4),
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );
}

TextStyle descp() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.25),
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );
}

TextStyle smallDescp({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.black,
  );
}
TextStyle smallDescp2({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(3.8),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.black,
  );
}

TextStyle smallTitle2() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(3),
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );
}

TextStyle textField({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.6),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.black,
  );
}

TextStyle hintField() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.5),
    fontWeight: FontWeight.w500,
    color: ColorConstants.grey,
  );
}

TextStyle buttonLarge() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(5.4),
    fontWeight: FontWeight.w500,
    color: ColorConstants.white,
  );
}

TextStyle buttonSmall() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.5),
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );
}
