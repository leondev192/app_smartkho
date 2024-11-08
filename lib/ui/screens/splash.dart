import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:app_smartkho/ui/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));

    FlutterNativeSplash.remove();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
