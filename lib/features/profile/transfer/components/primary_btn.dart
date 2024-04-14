import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.padding,
    required this.title,
    required this.onTap,
    required this.titleColor,
    this.iconColor = Colors.white,
  }) : super(key: key);
  final Color primaryColor, secondaryColor, titleColor, iconColor;
  final double padding;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: primaryColor,
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                  stops: const [
                    0,
                    1
                  ]),
              boxShadow: [
                BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(3, 5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
