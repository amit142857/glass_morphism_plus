import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Configuration data for glassmorphism styling across an application or subtree.
@immutable
class GlassThemeData with Diagnosticable {
  /// The default intensity of the background blur effect.
  final double blur;

  /// Optional horizontal blur intensity.
  final double? blurX;

  /// Optional vertical blur intensity.
  final double? blurY;

  /// The tile mode for the blur filter.
  final TileMode tileMode;

  /// The background opacity (0.0 to 1.0).
  final double opacity;

  /// The default corner radius for containers.
  final double borderRadius;

  /// Optional custom border radius geometry overriding [borderRadius].
  final BorderRadiusGeometry? customBorderRadius;

  /// The shape of the container.
  final BoxShape shape;

  /// The base tint color of the glass.
  final Color color;

  /// An optional gradient for the container's background fill.
  final Gradient? gradient;

  /// An optional gradient for the container's border stroke.
  final Gradient? borderGradient;

  /// The default border stroke width.
  final double borderWidth;

  /// The border stroke color when [borderGradient] is not set.
  final Color? borderColor;

  /// An optional complete [BoxBorder].
  final BoxBorder? border;

  /// Shadows cast behind the glass container.
  final List<BoxShadow>? boxShadow;

  /// Elevation depth for automatic soft shadows.
  final double? elevation;

  /// Color used for the elevation shadow.
  final Color? shadowColor;

  /// The default inner padding.
  final EdgeInsetsGeometry? padding;

  /// The default outer margin.
  final EdgeInsetsGeometry? margin;

  /// The clip behavior for container bounds.
  final Clip clipBehavior;

  /// Whether blur is enabled. If false, skips [BackdropFilter] for performance.
  final bool isBlurEnabled;

  /// Creates a [GlassThemeData] configuration.
  const GlassThemeData({
    this.blur = 15.0,
    this.blurX,
    this.blurY,
    this.tileMode = TileMode.clamp,
    this.opacity = 0.1,
    this.borderRadius = 20.0,
    this.customBorderRadius,
    this.shape = BoxShape.rectangle,
    this.color = Colors.white,
    this.gradient,
    this.borderGradient,
    this.borderWidth = 1.5,
    this.borderColor,
    this.border,
    this.boxShadow,
    this.elevation,
    this.shadowColor,
    this.padding,
    this.margin,
    this.clipBehavior = Clip.antiAlias,
    this.isBlurEnabled = true,
  });

  /// The fallback theme values.
  const GlassThemeData.fallback()
    : blur = 15.0,
      blurX = null,
      blurY = null,
      tileMode = TileMode.clamp,
      opacity = 0.1,
      borderRadius = 20.0,
      customBorderRadius = null,
      shape = BoxShape.rectangle,
      color = Colors.white,
      gradient = null,
      borderGradient = null,
      borderWidth = 1.5,
      borderColor = null,
      border = null,
      boxShadow = null,
      elevation = null,
      shadowColor = null,
      padding = null,
      margin = null,
      clipBehavior = Clip.antiAlias,
      isBlurEnabled = true;

  /// Returns a copy of this [GlassThemeData] with the given fields updated.
  GlassThemeData copyWith({
    double? blur,
    double? blurX,
    double? blurY,
    TileMode? tileMode,
    double? opacity,
    double? borderRadius,
    BorderRadiusGeometry? customBorderRadius,
    BoxShape? shape,
    Color? color,
    Gradient? gradient,
    Gradient? borderGradient,
    double? borderWidth,
    Color? borderColor,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    double? elevation,
    Color? shadowColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Clip? clipBehavior,
    bool? isBlurEnabled,
  }) {
    return GlassThemeData(
      blur: blur ?? this.blur,
      blurX: blurX ?? this.blurX,
      blurY: blurY ?? this.blurY,
      tileMode: tileMode ?? this.tileMode,
      opacity: opacity ?? this.opacity,
      borderRadius: borderRadius ?? this.borderRadius,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
      shape: shape ?? this.shape,
      color: color ?? this.color,
      gradient: gradient ?? this.gradient,
      borderGradient: borderGradient ?? this.borderGradient,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      isBlurEnabled: isBlurEnabled ?? this.isBlurEnabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassThemeData &&
        other.blur == blur &&
        other.blurX == blurX &&
        other.blurY == blurY &&
        other.tileMode == tileMode &&
        other.opacity == opacity &&
        other.borderRadius == borderRadius &&
        other.customBorderRadius == customBorderRadius &&
        other.shape == shape &&
        other.color == color &&
        other.gradient == gradient &&
        other.borderGradient == borderGradient &&
        other.borderWidth == borderWidth &&
        other.borderColor == borderColor &&
        other.border == border &&
        listEquals(other.boxShadow, boxShadow) &&
        other.elevation == elevation &&
        other.shadowColor == shadowColor &&
        other.padding == padding &&
        other.margin == margin &&
        other.clipBehavior == clipBehavior &&
        other.isBlurEnabled == isBlurEnabled;
  }

  @override
  int get hashCode => Object.hashAll([
    blur,
    blurX,
    blurY,
    tileMode,
    opacity,
    borderRadius,
    customBorderRadius,
    shape,
    color,
    gradient,
    borderGradient,
    borderWidth,
    borderColor,
    border,
    boxShadow == null ? null : Object.hashAll(boxShadow!),
    elevation,
    shadowColor,
    padding,
    margin,
    clipBehavior,
    isBlurEnabled,
  ]);
}

/// An [InheritedWidget] that provides [GlassThemeData] to its descendants.
class GlassTheme extends InheritedWidget {
  /// The glass theme configuration.
  final GlassThemeData data;

  /// Creates a [GlassTheme] widget.
  const GlassTheme({super.key, required this.data, required super.child});

  /// Obtains the closest [GlassThemeData] from the given [context].
  ///
  /// If no [GlassTheme] ancestor is found, returns [GlassThemeData.fallback].
  static GlassThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<GlassTheme>();
    return theme?.data ?? const GlassThemeData.fallback();
  }

  /// Obtains the closest [GlassThemeData] from the given [context], if any.
  static GlassThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlassTheme>()?.data;
  }

  @override
  bool updateShouldNotify(covariant GlassTheme oldWidget) =>
      data != oldWidget.data;
}
