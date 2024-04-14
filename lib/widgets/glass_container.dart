import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final double blur;
  final AlignmentGeometry? alignment;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 10,
    this.blur = 28,
    this.alignment,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          alignment: alignment,
          padding: padding,
          decoration: BoxDecoration(
            // color: Colors.white.withOpacity(0.15), // Semi-transparent container
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3), // Light border for contrast
              width: 1.5,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.withOpacity(0.15),
                Colors.grey.withOpacity(0.25),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// SecondaryGlassContainer that is used inside the GlassContainer

// Assuming the GlassContainer class is defined as provided

class GlassContainerSecondary extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final double blur;
  final AlignmentGeometry? alignment;
  final Widget child;

  const GlassContainerSecondary({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 10, // Default borderRadius can be the same or different
    this.blur = 0.10, // Default blur can be the same or slightly adjusted
    this.alignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          alignment: alignment,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            border: Border.all(
              color: Colors.white.withOpacity(0.2), // Slightly different border color for contrast
              width: 1.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1), // Slightly less opaque for a subtler effect
                Colors.white.withOpacity(0.2), // Adjusted for a slight variation in shade
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
