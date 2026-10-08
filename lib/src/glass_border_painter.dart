import 'package:flutter/material.dart';

/// A custom painter that renders a smooth gradient stroke border
/// along a rounded rectangle or circular path.
class GlassBorderPainter extends CustomPainter {
  /// The gradient used to paint the border.
  final Gradient gradient;

  /// The stroke width of the border.
  final double borderWidth;

  /// The corner radius for rectangular shapes.
  final BorderRadiusGeometry borderRadius;

  /// The shape of the border: [BoxShape.rectangle] or [BoxShape.circle].
  final BoxShape shape;

  /// Creates a [GlassBorderPainter].
  const GlassBorderPainter({
    required this.gradient,
    this.borderWidth = 1.5,
    this.borderRadius = BorderRadius.zero,
    this.shape = BoxShape.rectangle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (borderWidth <= 0) return;

    final rect = Rect.fromLTWH(
      borderWidth / 2,
      borderWidth / 2,
      size.width - borderWidth,
      size.height - borderWidth,
    );

    final paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..isAntiAlias = true;

    if (shape == BoxShape.circle) {
      canvas.drawCircle(rect.center, rect.width / 2, paint);
    } else {
      final rrect = borderRadius.resolve(TextDirection.ltr).toRRect(rect);
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant GlassBorderPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.shape != shape;
  }
}
