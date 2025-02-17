import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final bool enabled;
  final bool autofocus;
  final bool showCursor;
  final double borderRadius;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showErrorBorder;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final bool isDense;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = false,
    this.showCursor = true,
    this.borderRadius = 12,
    this.fillColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.cursorColor,
    this.contentPadding,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.showErrorBorder = true,
    this.border,
    this.boxShadow,
    this.isDense = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.border,
        boxShadow: widget.boxShadow,
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        showCursor: widget.showCursor,
        style: widget.textStyle?.copyWith(
          color: widget.textColor ?? theme.textTheme.bodyLarge?.color,
        ) ?? TextStyle(color: widget.textColor ?? theme.textTheme.bodyLarge?.color),
        cursorColor: widget.cursorColor ?? theme.primaryColor,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.errorText,
          filled: true,
          isDense: widget.isDense,
          fillColor: widget.fillColor ?? theme.cardColor,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefix: widget.prefix,
          suffix: widget.suffix,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          labelStyle: widget.labelStyle?.copyWith(
            color: _isFocused
                ? widget.labelColor ?? theme.primaryColor
                : widget.labelColor ?? theme.textTheme.bodyLarge?.color,
          ),
          hintStyle: widget.hintStyle?.copyWith(
            color: widget.hintColor ?? theme.textTheme.bodySmall?.color,
          ),
          errorStyle: widget.errorStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.enabledBorderColor ?? theme.dividerColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.enabledBorderColor ?? theme.dividerColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? theme.primaryColor,
            ),
          ),
          errorBorder: widget.showErrorBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: widget.errorBorderColor ?? theme.colorScheme.error,
                  ),
                )
              : null,
          focusedErrorBorder: widget.showErrorBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: widget.errorBorderColor ?? theme.colorScheme.error,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
