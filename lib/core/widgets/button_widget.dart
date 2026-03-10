import 'package:flutter/material.dart';
import 'package:task_management_system/core/values/values.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.gradient,
    this.height,
    this.width,
    this.textColor,
    this.icon,
    this.borderColor,
    this.fontSize,
    this.radius,
    this.horizontal,
  });

  final String text;
  final void Function()? onPressed;

  final Color? color;
  final Gradient? gradient;

  final Color? borderColor;
  final Color? textColor;

  final double? height;
  final double? width;
  final Widget? icon;

  final double? fontSize;
  final double? radius;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: horizontal ?? 0),
      child: SizedBox(
        height: height ?? 45,
        width: width ?? double.infinity,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius ?? 10),
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                color: gradient == null ? color : null,
                gradient: gradient,
                borderRadius: BorderRadius.circular(radius ?? 10),
                border: Border.all(
                  color: borderColor ?? Colors.transparent,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox(),
                  if (icon != null) const SizedBox(width: 6),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: fontSize ?? 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}