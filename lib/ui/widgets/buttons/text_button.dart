import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.primaryColor, // Màu chữ
              fontSize: AppFonts.medium,
            ),
          ),
        ));
  }
}
