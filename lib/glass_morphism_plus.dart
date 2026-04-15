/// A high-performance library for creating Glassmorphism effects in Flutter.
// ignore: unnecessary_library_name
library glass_morphism_plus;

import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that creates a realistic frosted glass effect with
/// customizable blur, opacity, and border gradients.
class GlassContainer extends StatelessWidget {
  /// The widget to be placed inside the glass container.
  final Widget child;

  /// The intensity of the background blur effect. Defaults to 15.0.
  final double blur;

  /// The background color opacity (0.0 to 1.0). Defaults to 0.1.
  final double opacity;

  /// The corner radius of the container. Defaults to 20.0.
  final double borderRadius;

  /// The base color of the glass. Defaults to [Colors.white].
  final Color color;

  /// An optional gradient for the border to simulate light refraction.
  final Gradient? borderGradient;

  /// The inner padding of the container.
  final EdgeInsetsGeometry? padding;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// Creates a [GlassContainer] widget.
  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.opacity = 0.1,
    this.borderRadius = 20.0,
    this.color = Colors.white,
    this.borderGradient,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: color.withValues(alpha:  opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(width: 1.5, color: color.withValues(alpha: 0.2)),
            gradient:
                borderGradient ??
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withValues(alpha:  0.3), color.withValues(alpha: 0.05)],
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}
