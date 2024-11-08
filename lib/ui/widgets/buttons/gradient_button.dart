import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.gradientStartColor, // Sử dụng màu từ AppColors
              AppColors.gradientEndColor, // Sử dụng màu từ AppColors
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // Đường viền bo tròn
        ),
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white, // Màu chữ
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
