import 'package:flutter/material.dart';

import 'glass_container.dart';

/// A card widget styled with frosted glassmorphism aesthetics.
///
/// Can be constructed with a custom [child] or with structured card components:
/// [title], [subtitle], [leading], and [trailing].
class GlassCard extends StatelessWidget {
  /// The main content widget of the card. If omitted, [title] and/or [subtitle] can be used.
  final Widget? child;

  /// Optional leading widget (e.g. an icon or avatar).
  final Widget? leading;

  /// Optional primary title text or widget.
  final Widget? title;

  /// Optional secondary subtitle text or widget.
  final Widget? subtitle;

  /// Optional trailing widget (e.g. an action button or status chip).
  final Widget? trailing;

  /// The width of the card.
  final double? width;

  /// The height of the card.
  final double? height;

  /// Constraints for the card size.
  final BoxConstraints? constraints;

  /// Padding inside the card. Defaults to `EdgeInsets.all(16.0)`.
  final EdgeInsetsGeometry padding;

  /// Margin around the card. Defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)`.
  final EdgeInsetsGeometry margin;

  /// Background blur intensity.
  final double? blur;

  /// Horizontal blur intensity.
  final double? blurX;

  /// Vertical blur intensity.
  final double? blurY;

  /// Opacity of the background color (0.0 to 1.0).
  final double? opacity;

  /// Corner radius of the card. Defaults to 20.0.
  final double? borderRadius;

  /// Custom corner radius geometry (e.g. [BorderRadius.only]).
  final BorderRadiusGeometry? customBorderRadius;

  /// Base glass tint color.
  final Color? color;

  /// Fill gradient for the card background.
  final Gradient? gradient;

  /// Gradient for the card's border stroke.
  final Gradient? borderGradient;

  /// Border width. Defaults to 1.5.
  final double? borderWidth;

  /// Border color.
  final Color? borderColor;

  /// Custom border.
  final BoxBorder? border;

  /// Custom box shadows.
  final List<BoxShadow>? boxShadow;

  /// Elevation depth for automatic soft drop shadows. Defaults to 4.0.
  final double? elevation;

  /// Shadow color for elevation.
  final Color? shadowColor;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Callback when the card is long-pressed.
  final VoidCallback? onLongPress;

  /// Splash color for the ripple effect.
  final Color? splashColor;

  /// Highlight color for the ripple effect.
  final Color? highlightColor;

  /// Creates a [GlassCard].
  const GlassCard({
    super.key,
    this.child,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.width,
    this.height,
    this.constraints,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.blur,
    this.blurX,
    this.blurY,
    this.opacity,
    this.borderRadius,
    this.customBorderRadius,
    this.color,
    this.gradient,
    this.borderGradient,
    this.borderWidth,
    this.borderColor,
    this.border,
    this.boxShadow,
    this.elevation = 4.0,
    this.shadowColor,
    this.onTap,
    this.onLongPress,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget? content = child;

    if (content == null &&
        (title != null ||
            subtitle != null ||
            leading != null ||
            trailing != null)) {
      content = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 16.0)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ) ??
                        const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    child: title!,
                  ),
                if (title != null && subtitle != null)
                  const SizedBox(height: 4.0),
                if (subtitle != null)
                  DefaultTextStyle(
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ) ??
                        const TextStyle(fontSize: 13.0, color: Colors.white70),
                    child: subtitle!,
                  ),
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 16.0), trailing!],
        ],
      );
    }

    return GlassContainer(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      blur: blur,
      blurX: blurX,
      blurY: blurY,
      opacity: opacity,
      borderRadius: borderRadius,
      customBorderRadius: customBorderRadius,
      color: color,
      gradient: gradient,
      borderGradient: borderGradient,
      borderWidth: borderWidth,
      borderColor: borderColor,
      border: border,
      boxShadow: boxShadow,
      elevation: elevation,
      shadowColor: shadowColor,
      onTap: onTap,
      onLongPress: onLongPress,
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: content,
    );
  }
}
