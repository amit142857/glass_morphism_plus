import 'package:flutter/material.dart';

import 'glass_container.dart';

/// A button styled with frosted glassmorphism aesthetics.
class GlassButton extends StatefulWidget {
  /// Callback triggered when the button is pressed.
  final VoidCallback? onPressed;

  /// Custom child widget. If omitted, [label] and/or [icon] are displayed.
  final Widget? child;

  /// Optional icon widget displayed before the label.
  final Widget? icon;

  /// Optional text or widget label.
  final Widget? label;

  /// The width of the button.
  final double? width;

  /// The height of the button. Defaults to 48.0.
  final double height;

  /// Inner padding. Defaults to `EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)`.
  final EdgeInsetsGeometry padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Corner radius. Defaults to 16.0.
  final double borderRadius;

  /// Custom corner radius geometry.
  final BorderRadiusGeometry? customBorderRadius;

  /// Blur intensity. Defaults to 15.0.
  final double blur;

  /// Background opacity. Defaults to 0.15.
  final double opacity;

  /// Base tint color. Defaults to [Colors.white].
  final Color color;

  /// Custom fill gradient.
  final Gradient? gradient;

  /// Gradient for the border stroke.
  final Gradient? borderGradient;

  /// Border width. Defaults to 1.5.
  final double borderWidth;

  /// Border color.
  final Color? borderColor;

  /// Elevation shadow depth. Defaults to 2.0.
  final double elevation;

  /// Shadow color.
  final Color? shadowColor;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Custom loading indicator widget when [isLoading] is true.
  final Widget? loadingWidget;

  /// Splash color for the tap ripple.
  final Color? splashColor;

  /// Highlight color when pressed.
  final Color? highlightColor;

  /// Creates a [GlassButton].
  const GlassButton({
    super.key,
    required this.onPressed,
    this.child,
    this.icon,
    this.label,
    this.width,
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.margin,
    this.borderRadius = 16.0,
    this.customBorderRadius,
    this.blur = 15.0,
    this.opacity = 0.15,
    this.color = Colors.white,
    this.gradient,
    this.borderGradient,
    this.borderWidth = 1.5,
    this.borderColor,
    this.elevation = 2.0,
    this.shadowColor,
    this.isLoading = false,
    this.loadingWidget,
    this.splashColor,
    this.highlightColor,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (widget.isLoading) {
      content =
          widget.loadingWidget ??
          const SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
    } else if (widget.child != null) {
      content = widget.child!;
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            if (widget.label != null) const SizedBox(width: 8.0),
          ],
          if (widget.label != null)
            DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              child: widget.label!,
            ),
        ],
      );
    }

    final scale = _isPressed && widget.onPressed != null ? 0.96 : 1.0;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: GlassContainer(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        blur: widget.blur,
        opacity: widget.opacity,
        borderRadius: widget.borderRadius,
        customBorderRadius: widget.customBorderRadius,
        color: widget.color,
        gradient: widget.gradient,
        borderGradient: widget.borderGradient,
        borderWidth: widget.borderWidth,
        borderColor: widget.borderColor,
        elevation: widget.elevation,
        shadowColor: widget.shadowColor,
        splashColor: widget.splashColor,
        highlightColor: widget.highlightColor,
        alignment: Alignment.center,
        onTap: widget.isLoading || widget.onPressed == null
            ? null
            : () {
                widget.onPressed?.call();
              },
        child: Listener(
          onPointerDown: (_) {
            if (widget.onPressed != null && !widget.isLoading) {
              setState(() => _isPressed = true);
            }
          },
          onPointerUp: (_) {
            if (_isPressed) setState(() => _isPressed = false);
          },
          onPointerCancel: (_) {
            if (_isPressed) setState(() => _isPressed = false);
          },
          child: content,
        ),
      ),
    );
  }
}

/// A circular or rounded icon button with frosted glassmorphism aesthetics.
class GlassIconButton extends StatelessWidget {
  /// The icon widget to display.
  final Widget icon;

  /// Callback when the icon button is pressed.
  final VoidCallback? onPressed;

  /// The size (both width and height) of the button. Defaults to 44.0.
  final double size;

  /// The shape of the button: [BoxShape.circle] or [BoxShape.rectangle].
  final BoxShape shape;

  /// Corner radius when [shape] is [BoxShape.rectangle]. Defaults to 12.0.
  final double borderRadius;

  /// Background blur intensity. Defaults to 15.0.
  final double blur;

  /// Background opacity. Defaults to 0.15.
  final double opacity;

  /// Base glass color. Defaults to [Colors.white].
  final Color color;

  /// Custom fill gradient.
  final Gradient? gradient;

  /// Gradient for the border stroke.
  final Gradient? borderGradient;

  /// Border width. Defaults to 1.5.
  final double borderWidth;

  /// Border color.
  final Color? borderColor;

  /// Elevation shadow depth. Defaults to 2.0.
  final double elevation;

  /// Optional tooltip message.
  final String? tooltip;

  /// Creates a [GlassIconButton].
  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44.0,
    this.shape = BoxShape.circle,
    this.borderRadius = 12.0,
    this.blur = 15.0,
    this.opacity = 0.15,
    this.color = Colors.white,
    this.gradient,
    this.borderGradient,
    this.borderWidth = 1.5,
    this.borderColor,
    this.elevation = 2.0,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = GlassContainer(
      width: size,
      height: size,
      shape: shape,
      borderRadius: shape == BoxShape.circle ? 0 : borderRadius,
      blur: blur,
      opacity: opacity,
      color: color,
      gradient: gradient,
      borderGradient: borderGradient,
      borderWidth: borderWidth,
      borderColor: borderColor,
      elevation: elevation,
      alignment: Alignment.center,
      onTap: onPressed,
      child: icon,
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
