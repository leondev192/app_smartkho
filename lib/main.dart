import 'package:app_smartkho/ui/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // Giữ màn hình Splash trong khi ứng dụng khởi tạo
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartKho App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // Hiển thị SplashScreen trước
    );
  }
}
