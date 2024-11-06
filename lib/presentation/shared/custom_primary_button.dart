import 'package:flutter/material.dart';
import 'package:thechnical_assignment_tots/config/config.dart';

class PrimaryCustomButton extends StatelessWidget {
  const PrimaryCustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.height = 50,
      this.primaryColor = true,
      this.width = 100,
      this.backgroundColor,
      this.leftIcon,
      this.rightIcon});

  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final bool primaryColor;
  final Color? backgroundColor;
  final Widget? leftIcon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed.call();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, height),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (leftIcon != null)
            Container(
              child: leftIcon,
            ),
          if (leftIcon != null || rightIcon != null) const Spacer(),
          Text(
            text,
            style: TextStyles.bodyStyle(color: Colors.white, isBold: false),
          ),
          if (leftIcon != null || rightIcon != null) const Spacer(),
          if (rightIcon != null)
            Container(
              child: rightIcon,
            ),
        ],
      ),
    );
  }
}
