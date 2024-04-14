import 'package:flutter/material.dart';

class CameraBorders extends StatelessWidget {
  const CameraBorders({
    Key? key,
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
  }) : super(key: key);
  final double? top, left, right, bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
