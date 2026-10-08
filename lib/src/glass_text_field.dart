import 'package:flutter/material.dart';

import 'glass_container.dart';

/// A text input field wrapped with frosted glassmorphism aesthetics,
/// supporting focus animations, custom gradient borders, and icons.
class GlassTextField extends StatefulWidget {
  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The initial value of the text field if no [controller] is provided.
  final String? initialValue;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Placeholder hint text displayed when the input is empty.
  final String? hintText;

  /// Label text displayed above or inside the input field.
  final String? labelText;

  /// Leading icon widget.
  final Widget? prefixIcon;

  /// Trailing icon widget.
  final Widget? suffixIcon;

  /// Whether to obscure the text being entered (e.g. for passwords).
  final bool obscureText;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// The action button on the virtual keyboard.
  final TextInputAction? textInputAction;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// The color of the cursor.
  final Color? cursorColor;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when submission action is triggered.
  final ValueChanged<String>? onSubmitted;

  /// Validation function for forms.
  final FormFieldValidator<String>? validator;

  /// Whether the input is enabled.
  final bool enabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether to autofocus this input on mount.
  final bool autofocus;

  /// The maximum number of lines. Defaults to 1.
  final int? maxLines;

  /// The height of the text field container.
  final double? height;

  /// Inner padding for the input field. Defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0)`.
  final EdgeInsetsGeometry padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Background blur intensity. Defaults to 15.0.
  final double blur;

  /// Background opacity. Defaults to 0.12.
  final double opacity;

  /// Corner radius. Defaults to 16.0.
  final double borderRadius;

  /// Custom corner radius geometry.
  final BorderRadiusGeometry? customBorderRadius;

  /// Base glass tint color. Defaults to [Colors.white].
  final Color color;

  /// Custom fill gradient.
  final Gradient? gradient;

  /// Default border gradient when unfocused.
  final Gradient? borderGradient;

  /// Border gradient when focused.
  final Gradient? focusedBorderGradient;

  /// Border width. Defaults to 1.5.
  final double borderWidth;

  /// Border color when unfocused.
  final Color? borderColor;

  /// Border color when focused.
  final Color? focusedBorderColor;

  /// Shadow depth for elevation. Defaults to 0.
  final double elevation;

  /// Shadow color.
  final Color? shadowColor;

  /// Creates a [GlassTextField].
  const GlassTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.cursorColor,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    this.margin,
    this.blur = 15.0,
    this.opacity = 0.12,
    this.borderRadius = 16.0,
    this.customBorderRadius,
    this.color = Colors.white,
    this.gradient,
    this.borderGradient,
    this.focusedBorderGradient,
    this.borderWidth = 1.5,
    this.borderColor,
    this.focusedBorderColor,
    this.elevation = 0.0,
    this.shadowColor,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant GlassTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderGradient = _isFocused
        ? (widget.focusedBorderGradient ?? widget.borderGradient)
        : widget.borderGradient;

    final effectiveBorderColor = _isFocused
        ? (widget.focusedBorderColor ??
              widget.borderColor ??
              widget.color.withValues(alpha: 0.6))
        : (widget.borderColor ?? widget.color.withValues(alpha: 0.2));

    return GlassContainer(
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      blur: widget.blur,
      opacity: _isFocused
          ? (widget.opacity * 1.3).clamp(0.0, 1.0)
          : widget.opacity,
      borderRadius: widget.borderRadius,
      customBorderRadius: widget.customBorderRadius,
      color: widget.color,
      gradient: widget.gradient,
      borderGradient: effectiveBorderGradient,
      borderWidth: widget.borderWidth,
      borderColor: effectiveBorderColor,
      elevation: _isFocused ? widget.elevation + 2.0 : widget.elevation,
      shadowColor: widget.shadowColor,
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          maxLines: widget.maxLines,
          cursorColor: widget.cursorColor ?? Colors.white,
          style:
              widget.style ??
              const TextStyle(color: Colors.white, fontSize: 15.0),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white54, fontSize: 14.0),
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.white70, fontSize: 14.0),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
        ),
      ),
    );
  }
}
