import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? loadingColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Widget? prefix;
  final Widget? suffix;
  final bool disabled;
  final Duration animationDuration;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.loadingColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.padding,
    this.border,
    this.boxShadow,
    this.prefix,
    this.suffix,
    this.disabled = false,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: animationDuration,
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: (disabled || isLoading) ? null : onPressed,
        padding: padding ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: disabled
                ? (backgroundColor ?? theme.primaryColor).withOpacity(0.5)
                : backgroundColor ?? theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            boxShadow: boxShadow,
          ),
          child: Container(
            width: width,
            height: height,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefix != null && !isLoading) ...[
                  prefix!,
                  const SizedBox(width: 8),
                ],
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        loadingColor ?? textColor ?? Colors.white,
                      ),
                    ),
                  )
                else
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
                if (suffix != null && !isLoading) ...[
                  const SizedBox(width: 8),
                  suffix!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
