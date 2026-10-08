import 'dart:ui';
import 'package:flutter/material.dart';

/// An [AppBar] styled with a frosted glass backdrop, perfect for apps
/// that use `extendBodyBehindAppBar: true`.
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// A widget to display before the [title].
  final Widget? leading;

  /// Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// This widget appears across the bottom of the app bar.
  final PreferredSizeWidget? bottom;

  /// Whether the [title] should be centered.
  final bool? centerTitle;

  /// Controls whether one should try to imply the leading widget if null.
  final bool automaticallyImplyLeading;

  /// The height of the toolbar component of the [GlassAppBar].
  final double toolbarHeight;

  /// The intensity of the background blur. Defaults to 20.0.
  final double blur;

  /// Background opacity (0.0 to 1.0). Defaults to 0.15.
  final double opacity;

  /// Base glass tint color. Defaults to [Colors.white].
  final Color color;

  /// Fill gradient for the app bar.
  final Gradient? gradient;

  /// Bottom border stroke gradient.
  final Gradient? borderGradient;

  /// Bottom border stroke width. Defaults to 1.0. Set to 0 to disable border.
  final double borderWidth;

  /// Bottom border stroke color.
  final Color? borderColor;

  /// Shadows cast by the app bar.
  final List<BoxShadow>? boxShadow;

  /// Elevation depth for automatic shadow. Defaults to 0.0.
  final double elevation;

  /// Creates a [GlassAppBar].
  const GlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.toolbarHeight = kToolbarHeight,
    this.blur = 20.0,
    this.opacity = 0.15,
    this.color = Colors.white,
    this.gradient,
    this.borderGradient,
    this.borderWidth = 1.0,
    this.borderColor,
    this.boxShadow,
    this.elevation = 0.0,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        borderColor ?? color.withValues(alpha: (opacity * 1.5).clamp(0.0, 1.0));

    final effectiveShadows =
        boxShadow ??
        (elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null);

    Widget background = Container(
      decoration: BoxDecoration(
        color: gradient == null ? color.withValues(alpha: opacity) : null,
        gradient: gradient,
        border: borderGradient == null && borderWidth > 0
            ? Border(
                bottom: BorderSide(
                  width: borderWidth,
                  color: effectiveBorderColor,
                ),
              )
            : null,
      ),
    );

    if (borderGradient != null && borderWidth > 0) {
      background = CustomPaint(
        foregroundPainter: _BottomBorderGradientPainter(
          gradient: borderGradient!,
          borderWidth: borderWidth,
        ),
        child: background,
      );
    }

    final frostedBackground = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: background,
      ),
    );

    return Container(
      decoration: effectiveShadows != null
          ? BoxDecoration(boxShadow: effectiveShadows)
          : null,
      child: AppBar(
        title: title,
        leading: leading,
        actions: actions,
        bottom: bottom,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: frostedBackground,
      ),
    );
  }
}

class _BottomBorderGradientPainter extends CustomPainter {
  final Gradient gradient;
  final double borderWidth;

  _BottomBorderGradientPainter({
    required this.gradient,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (borderWidth <= 0) return;
    final paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final y = size.height - borderWidth / 2;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }

  @override
  bool shouldRepaint(covariant _BottomBorderGradientPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.borderWidth != borderWidth;
  }
}
