import 'package:app_smartkho/logic/providers/auth_provider.dart';
import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/widgets/buttons/gradient_button.dart';
import 'package:app_smartkho/ui/widgets/buttons/loginWithGoogle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_smartkho/data/services/auth_service.dart';
import 'package:app_smartkho/ui/widgets/buttons/text_button.dart';
import 'package:app_smartkho/ui/widgets/inputs/custom_input.dart';
import 'package:app_smartkho/ui/widgets/loadings/custom_loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _emailError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _emailError = email.isEmpty;
      _passwordError = password.isEmpty;
    });

    if (_emailError || _passwordError) return;

    setState(() {
      _isLoading = true;
    });

    final result = await _authService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (result != null && result['status'] == 'success') {
      final token = result['data']['token'];
      final email = result['data']['user']['email'];
      final fullName = result['data']['user']['fullName'];
      final avatarUrl = result['data']['user']['avatarUrl'];
      final phoneNumber = result['data']['user']['phoneNumber'];
      final address = result['data']['user']['address'];
      final createdAt = result['data']['user']['createdAt'];
      SharedPreferences information = await SharedPreferences.getInstance();
      information.setString('email', email);
      information.setString('fullName', fullName);
      information.setString('avatarUrl', avatarUrl);
      information.setString('phoneNumber', phoneNumber);
      information.setString('createdAt', createdAt);
      information.setString('address', address);

      await Provider.of<AuthProvider>(context, listen: false).login(token);

      Navigator.pushReplacementNamed(context, '/main');
    } else {
      final errorMessage = result?['message'] ?? 'Đăng nhập thất bại.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: AppColors.primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Đăng nhập')),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Image(
                  image: AssetImage('assets/images/smartkho.png'),
                  width: 160,
                  height: 160,
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  label: 'Email',
                  controller: _emailController,
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  isError: _emailError,
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  label: 'Mật khẩu',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  isError: _passwordError,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: 'Quên mật khẩu?',
                      onPressed: () {
                        // Chức năng quên mật khẩu
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GradientButton(
                  text: 'Đăng nhập',
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Color.fromRGBO(224, 229, 236, 100),
                        thickness: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Hoặc'),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Color.fromRGBO(224, 229, 236, 100),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LoginwithgoogleButton(onPressed: () {})
              ],
            ),
          ),
        ),
        if (_isLoading) const CustomLoadingOverlay(isLoading: true),
      ],
    );
  }
}
