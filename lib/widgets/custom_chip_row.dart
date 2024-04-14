import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class CustomChipRow extends StatelessWidget {
  const CustomChipRow({
    super.key,
    required this.selectedIndex,
    required this.testList,
    required this.onSelected,
    required this.isiOS,
  });

  final int selectedIndex;
  final List<String> testList;
  final Function(int) onSelected;
  final bool isiOS;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < testList.length; i++)
            // Check for Platform
            (Theme.of(context).platform == TargetPlatform.iOS && isiOS)
                ? CustomIosChip(
                    isSelected: selectedIndex == i,
                    text: testList[i],
                    onTap: () => onSelected(i),
                  )
                : CustomAndroidChip(
                    isSelected: selectedIndex == i,
                    text: testList[i],
                    onTap: () => onSelected(i),
                  ),
        ],
      ),
    );
  }
}

class CustomIosChip extends StatelessWidget {
  const CustomIosChip({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Palette.primary : Colors.transparent,
          border: isSelected ? null : Border.all(color: Palette.primary, width: 1),
        ),
        child: Text(
          text,
          style: smallDescp2(color: isSelected ? Colors.black : Palette.primary),
        ),
      ),
    );
  }
}

class CustomAndroidChip extends StatelessWidget {
  const CustomAndroidChip({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              text,
              style: smallDescp(color: Colors.white),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: text.length * 6 + 8,
            color: isSelected ? Palette.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
