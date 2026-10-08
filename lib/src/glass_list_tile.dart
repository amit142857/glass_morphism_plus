import 'package:flutter/material.dart';

import 'glass_container.dart';

/// A [ListTile] styled with frosted glassmorphism aesthetics.
class GlassListTile extends StatelessWidget {
  /// A widget to display before the title.
  final Widget? leading;

  /// The primary content of the list tile.
  final Widget? title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Called when the user long-presses this list tile.
  final VoidCallback? onLongPress;

  /// Whether this list tile is interactive. Defaults to true.
  final bool enabled;

  /// Internal padding for the tile. Defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)`.
  final EdgeInsetsGeometry contentPadding;

  /// External margin around the tile. Defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0)`.
  final EdgeInsetsGeometry margin;

  /// Whether this list tile is part of a vertically dense list.
  final bool? dense;

  /// Intensity of the background blur.
  final double? blur;

  /// Opacity of the background color (0.0 to 1.0).
  final double? opacity;

  /// Corner radius of the tile. Defaults to 16.0.
  final double? borderRadius;

  /// Custom corner radius geometry.
  final BorderRadiusGeometry? customBorderRadius;

  /// Base glass tint color.
  final Color? color;

  /// Custom fill gradient.
  final Gradient? gradient;

  /// Gradient for the border stroke.
  final Gradient? borderGradient;

  /// Border width. Defaults to 1.5.
  final double? borderWidth;

  /// Border color.
  final Color? borderColor;

  /// Custom border.
  final BoxBorder? border;

  /// Elevation shadow depth.
  final double? elevation;

  /// Shadow color.
  final Color? shadowColor;

  /// Splash color on tap.
  final Color? splashColor;

  /// Highlight color on tap.
  final Color? highlightColor;

  /// Creates a [GlassListTile].
  const GlassListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    ),
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    this.dense,
    this.blur,
    this.opacity,
    this.borderRadius = 16.0,
    this.customBorderRadius,
    this.color,
    this.gradient,
    this.borderGradient,
    this.borderWidth,
    this.borderColor,
    this.border,
    this.elevation,
    this.shadowColor,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: margin,
      blur: blur,
      opacity: opacity,
      borderRadius: borderRadius,
      customBorderRadius: customBorderRadius,
      color: color,
      gradient: gradient,
      borderGradient: borderGradient,
      borderWidth: borderWidth,
      borderColor: borderColor,
      border: border,
      elevation: elevation,
      shadowColor: shadowColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      child: ListTile(
        leading: leading,
        title: title != null
            ? DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                child: title!,
              )
            : null,
        subtitle: subtitle != null
            ? DefaultTextStyle(
                style: const TextStyle(color: Colors.white70, fontSize: 13.0),
                child: subtitle!,
              )
            : null,
        trailing: trailing,
        contentPadding: contentPadding,
        dense: dense,
        enabled: enabled,
      ),
    );
  }
}

/// A subtle frosted horizontal divider.
class GlassDivider extends StatelessWidget {
  /// The divider's total height. Defaults to 16.0.
  final double height;

  /// The thickness of the line. Defaults to 1.0.
  final double thickness;

  /// The amount of empty space to the leading edge of the divider.
  final double indent;

  /// The amount of empty space to the trailing edge of the divider.
  final double endIndent;

  /// The color of the line. If null, uses a subtle white glow.
  final Color? color;

  /// An optional gradient for the divider line.
  final Gradient? gradient;

  /// Creates a [GlassDivider].
  const GlassDivider({
    super.key,
    this.height = 16.0,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGradient =
        gradient ??
        LinearGradient(
          colors: [
            Colors.transparent,
            (color ?? Colors.white).withValues(alpha: 0.25),
            Colors.transparent,
          ],
        );

    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          height: thickness,
          decoration: BoxDecoration(gradient: effectiveGradient),
        ),
      ),
    );
  }
}
