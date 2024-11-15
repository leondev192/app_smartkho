import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:flutter/material.dart';

class LoginwithgoogleButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  const LoginwithgoogleButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage('assets/images/google.png'),
                height: 20,
                width: 20),
            SizedBox(
              width: 20,
            ),
            Text('Đăng nhập với google'),
          ],
        ),
      ),
    );
  }
}
