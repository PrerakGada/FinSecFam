import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/color_constants.dart';
import '../utils/size_config.dart';
import 'text/small_widgets.dart';
import 'text/text_style.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.getPercentSize(15),
        width: width ?? SizeConfig.getPercentSize(80),
        margin: margin ??
            EdgeInsets.all(
              SizeConfig.getPercentSize(2),
            ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeConfig.getPercentSize(3),
            ),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                ColorConstants.primaryPurple,
                ColorConstants.secondaryPurple,
              ],
            )),
        child: textWidget(
          text: text,
          style: buttonLarge(),
        ),
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  final String text;
  final String? image;
  final VoidCallback onTap;

  const BorderedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.image,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.getPercentSize(15),
        width: SizeConfig.getPercentSize(80),
        margin: EdgeInsets.all(
          SizeConfig.getPercentSize(2),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.getPercentSize(3),
          ),
          border: Border.all(
            width: SizeConfig.getPercentSize(0.5),
            color: ColorConstants.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image!,
              height: SizeConfig.getPercentSize(7),
              width: SizeConfig.getPercentSize(7),
              fit: BoxFit.contain,
            ),
            textWidget(
              text: text,
              style: buttonSmall(),
            ),
          ],
        ),
      ),
    );
  }
}
