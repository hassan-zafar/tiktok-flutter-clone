import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/Theme/colors.dart';
import 'package:tiktok_tutorial/Theme/style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final Color? borderColor;
  final Color? color;
  final TextStyle? style;
  final Widget? icon;
  final Color? textColor;

  const CustomButton(ImageIcon imageIcon, {
    Key? key,
    this.text,
    this.onPressed,
    this.borderColor,
    this.color,
    this.style,
    this.icon,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.transparent,
          // color ?? mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        icon: icon ?? const SizedBox.shrink(),
        onPressed: onPressed as void Function()?,
        label: Text(
          text ?? 'Continue',
          style: style ??
              Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: textColor ?? secondaryColor),
        ),
      ),
    );
  }
}
