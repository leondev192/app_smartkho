import 'package:app_smartkho/logic/providers/auth_provider.dart';
import 'package:app_smartkho/ui/screens/auth/login.dart';
import 'package:app_smartkho/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkstatus extends StatelessWidget {
  const Checkstatus({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.isLoggedIn == true
        ? const MainScreen()
        : const LoginScreen();
  }
}
