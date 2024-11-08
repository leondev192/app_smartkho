import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final double width;
  final double height;

  const CustomLoadingOverlay({
    super.key,
    required this.isLoading,
    this.width = 60,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();

    return Stack(
      children: [
        const Opacity(
          opacity: 0.5,
          child: ModalBarrier(
            color: AppColors.borderColor,
            dismissible: false,
          ),
        ),
        Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryColor,
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
        ),
      ],
    );
  }
}
