import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  final double width;
  final double height;

  const CustomLoading({
    super.key,
    this.width = 70, // Kích thước mặc định
    this.height = 70,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
