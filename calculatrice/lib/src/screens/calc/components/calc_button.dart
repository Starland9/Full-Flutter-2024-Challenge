import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    required this.text,
    this.foregroundColor,
    this.fontSize,
    this.backgroundColor,
    this.size,
    this.radius,
    this.elevation,
    this.onTap,
  });

  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? fontSize;
  final Size? size;
  final double? radius;
  final double? elevation;
  final Function(String exp)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: (isDark(theme) && backgroundColor == null)
              ? const Color.fromARGB(133, 77, 77, 77)
              : backgroundColor ?? theme.colorScheme.background,
          elevation: elevation ?? 0,
          shadowColor: isDark(theme)
              ? theme.colorScheme.onBackground.withOpacity(0.1)
              : null,
          padding: EdgeInsets.zero,
          minimumSize: size ?? const Size(0, 0),
          fixedSize: size ?? const Size(60, 60),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 35),
          ),
        ),
        onPressed: () {
          onTap?.call(text);
        },
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: foregroundColor ?? theme.colorScheme.primary,
              fontSize: fontSize ?? 22,
            ),
          ),
        ),
      ),
    );
  }

  bool isDark(ThemeData theme) => theme.brightness == Brightness.dark;
}
