import 'dart:ui';
import 'package:flutter/material.dart';

import 'glass_border_painter.dart';
import 'glass_theme.dart';

/// A highly customizable widget that creates a realistic frosted glass effect
/// with background blur, adaptable opacity, gradients, custom borders, shadows,
/// and interactive touch feedback.
class GlassContainer extends StatelessWidget {
  /// The widget to be placed inside the glass container.
  final Widget? child;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// Additional constraints to apply to the child.
  final BoxConstraints? constraints;

  /// The inner padding of the container.
  final EdgeInsetsGeometry? padding;

  /// The outer margin of the container.
  final EdgeInsetsGeometry? margin;

  /// Align the child within the container.
  final AlignmentGeometry? alignment;

  /// The intensity of the background blur effect. Defaults to 15.0 or inherits from [GlassTheme].
  final double? blur;

  /// Optional horizontal blur intensity. If null, falls back to [blur].
  final double? blurX;

  /// Optional vertical blur intensity. If null, falls back to [blur].
  final double? blurY;

  /// The tile mode for the blur filter. Defaults to [TileMode.clamp].
  final TileMode? tileMode;

  /// A custom [ImageFilter] to use instead of the default blur filter.
  final ImageFilter? customFilter;

  /// Whether blur is enabled. If false, skips [BackdropFilter] for performance. Defaults to true.
  final bool? isBlurEnabled;

  /// The background color opacity (0.0 to 1.0). Defaults to 0.1 or inherits from [GlassTheme].
  final double? opacity;

  /// The corner radius of the container when using a rectangular shape. Defaults to 20.0.
  final double? borderRadius;

  /// Custom corner radius geometry (e.g. [BorderRadius.only]). Overrides [borderRadius].
  final BorderRadiusGeometry? customBorderRadius;

  /// The shape of the container. Can be [BoxShape.rectangle] or [BoxShape.circle].
  final BoxShape? shape;

  /// The base tint color of the glass. Defaults to [Colors.white] or inherits from [GlassTheme].
  final Color? color;

  /// An optional gradient for the container's background fill.
  final Gradient? gradient;

  /// Whether to apply a subtle default shimmer gradient when [gradient] is null.
  /// If set to false, a solid translucent color will be used instead.
  final bool useDefaultGradient;

  /// An optional gradient for the border stroke to simulate light refraction.
  final Gradient? borderGradient;

  /// The stroke width of the border. Defaults to 1.5. Set to 0 to disable border.
  final double? borderWidth;

  /// The color of the border when not using [borderGradient] or [border].
  final Color? borderColor;

  /// An optional full custom [BoxBorder]. If specified, overrides [borderWidth],
  /// [borderColor], and [borderGradient].
  final BoxBorder? border;

  /// A list of shadows cast behind this container for glow or elevation effects.
  final List<BoxShadow>? boxShadow;

  /// Elevation depth of the container, automatically generating soft drop shadows.
  final double? elevation;

  /// Color used for the elevation shadow.
  final Color? shadowColor;

  /// The clip behavior for the container corners. Defaults to [Clip.antiAlias].
  final Clip? clipBehavior;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, for the [transform].
  final AlignmentGeometry? transformAlignment;

  /// Callback when the container is tapped.
  final VoidCallback? onTap;

  /// Callback when the container is long-pressed.
  final VoidCallback? onLongPress;

  /// Callback when the container is double-tapped.
  final VoidCallback? onDoubleTap;

  /// Splash color for the ripple effect when [onTap] is provided.
  final Color? splashColor;

  /// Highlight color for the ripple effect when pressed.
  final Color? highlightColor;

  /// Hover color when mouse hovers over the container.
  final Color? hoverColor;

  /// Focus color when the container is focused.
  final Color? focusColor;

  /// The mouse cursor when hovering over the container.
  final MouseCursor? cursor;

  /// Creates a [GlassContainer] widget.
  const GlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.constraints,
    this.padding,
    this.margin,
    this.alignment,
    this.blur,
    this.blurX,
    this.blurY,
    this.tileMode,
    this.customFilter,
    this.isBlurEnabled,
    this.opacity,
    this.borderRadius,
    this.customBorderRadius,
    this.shape,
    this.color,
    this.gradient,
    this.useDefaultGradient = true,
    this.borderGradient,
    this.borderWidth,
    this.borderColor,
    this.border,
    this.boxShadow,
    this.elevation,
    this.shadowColor,
    this.clipBehavior,
    this.transform,
    this.transformAlignment,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.focusColor,
    this.cursor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    final effectiveBlur = blur ?? theme.blur;
    final effectiveBlurX = blurX ?? theme.blurX ?? effectiveBlur;
    final effectiveBlurY = blurY ?? theme.blurY ?? effectiveBlur;
    final effectiveTileMode = tileMode ?? theme.tileMode;
    final effectiveIsBlurEnabled = isBlurEnabled ?? theme.isBlurEnabled;
    final effectiveOpacity = opacity ?? theme.opacity;
    final effectiveColor = color ?? theme.color;
    final effectiveShape = shape ?? theme.shape;
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor =
        borderColor ??
        theme.borderColor ??
        effectiveColor.withValues(
          alpha: (effectiveOpacity * 1.5).clamp(0.0, 1.0),
        );
    final effectiveBorder = border ?? theme.border;
    final effectiveBorderGradient = borderGradient ?? theme.borderGradient;
    final effectiveClipBehavior = clipBehavior ?? theme.clipBehavior;
    final effectivePadding = padding ?? theme.padding;
    final effectiveMargin = margin ?? theme.margin;

    // Resolve border radius
    final BorderRadius resolvedRadius;
    if (customBorderRadius != null) {
      resolvedRadius = customBorderRadius!.resolve(
        Directionality.maybeOf(context) ?? TextDirection.ltr,
      );
    } else if (borderRadius != null) {
      resolvedRadius = BorderRadius.circular(borderRadius!);
    } else if (theme.customBorderRadius != null) {
      resolvedRadius = theme.customBorderRadius!.resolve(
        Directionality.maybeOf(context) ?? TextDirection.ltr,
      );
    } else {
      resolvedRadius = BorderRadius.circular(theme.borderRadius);
    }

    // Resolve shadows / elevation
    List<BoxShadow>? effectiveShadows = boxShadow ?? theme.boxShadow;
    final effectiveElevation = elevation ?? theme.elevation;
    if (effectiveShadows == null &&
        effectiveElevation != null &&
        effectiveElevation > 0) {
      final sColor = shadowColor ?? theme.shadowColor ?? Colors.black;
      effectiveShadows = [
        BoxShadow(
          color: sColor.withValues(alpha: 0.15),
          blurRadius: effectiveElevation * 2.5,
          spreadRadius: effectiveElevation * 0.2,
          offset: Offset(0, effectiveElevation * 0.8),
        ),
      ];
    }

    // Resolve fill gradient and color
    final Gradient? effectiveGradient = gradient ?? theme.gradient;
    final Gradient? fillGradient;
    final Color? fillColor;

    if (effectiveGradient != null) {
      fillGradient = effectiveGradient;
      fillColor = null;
    } else if (useDefaultGradient) {
      fillGradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          effectiveColor.withValues(
            alpha: (effectiveOpacity * 1.8).clamp(0.0, 1.0),
          ),
          effectiveColor.withValues(
            alpha: (effectiveOpacity * 0.4).clamp(0.0, 1.0),
          ),
        ],
      );
      fillColor = null;
    } else {
      fillGradient = null;
      fillColor = effectiveColor.withValues(alpha: effectiveOpacity);
    }

    // Determine border styling for Container
    final BoxBorder? containerBorder;
    if (effectiveBorder != null) {
      containerBorder = effectiveBorder;
    } else if (effectiveBorderGradient != null) {
      // Border is painted via GlassBorderPainter
      containerBorder = null;
    } else if (effectiveBorderWidth > 0) {
      containerBorder = Border.all(
        width: effectiveBorderWidth,
        color: effectiveBorderColor,
      );
    } else {
      containerBorder = null;
    }

    // Build the interactive child (if tap handlers provided)
    Widget? effectiveChild = child;
    final isInteractive =
        onTap != null || onLongPress != null || onDoubleTap != null;
    if (isInteractive && effectiveChild != null) {
      effectiveChild = Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          splashColor: splashColor,
          highlightColor: highlightColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          mouseCursor: cursor,
          borderRadius: effectiveShape == BoxShape.circle
              ? null
              : resolvedRadius,
          customBorder: effectiveShape == BoxShape.circle
              ? const CircleBorder()
              : null,
          child: effectiveChild,
        ),
      );
    }

    Widget innerBox = Container(
      alignment: alignment,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: fillColor,
        gradient: fillGradient,
        border: containerBorder,
        borderRadius: effectiveShape == BoxShape.circle ? null : resolvedRadius,
        shape: effectiveShape,
      ),
      child: effectiveChild,
    );

    // Apply gradient border painter if borderGradient is specified
    if (effectiveBorderGradient != null && effectiveBorderWidth > 0) {
      innerBox = CustomPaint(
        foregroundPainter: GlassBorderPainter(
          gradient: effectiveBorderGradient,
          borderWidth: effectiveBorderWidth,
          borderRadius: resolvedRadius,
          shape: effectiveShape,
        ),
        child: innerBox,
      );
    }

    // Apply BackdropFilter if blur is enabled
    Widget glassEffect = innerBox;
    if (effectiveIsBlurEnabled &&
        (effectiveBlurX > 0 || effectiveBlurY > 0 || customFilter != null)) {
      glassEffect = BackdropFilter(
        filter:
            customFilter ??
            ImageFilter.blur(
              sigmaX: effectiveBlurX,
              sigmaY: effectiveBlurY,
              tileMode: effectiveTileMode,
            ),
        child: innerBox,
      );
    }

    // Clip according to shape
    final Widget clippedContent;
    if (effectiveShape == BoxShape.circle) {
      clippedContent = ClipOval(
        clipBehavior: effectiveClipBehavior,
        child: glassEffect,
      );
    } else {
      clippedContent = ClipRRect(
        borderRadius: resolvedRadius,
        clipBehavior: effectiveClipBehavior,
        child: glassEffect,
      );
    }

    // Outer container for dimensions, shadows, margin, constraints, transform
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: effectiveMargin,
      transform: transform,
      transformAlignment: transformAlignment,
      decoration: BoxDecoration(
        shape: effectiveShape,
        borderRadius: effectiveShape == BoxShape.circle ? null : resolvedRadius,
        boxShadow: (effectiveShadows != null && effectiveShadows.isNotEmpty)
            ? effectiveShadows
            : null,
      ),
      child: clippedContent,
    );
  }
}
