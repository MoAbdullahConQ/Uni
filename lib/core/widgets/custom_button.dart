import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.style,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(text, style: style),
      ),
    );
  }
}
