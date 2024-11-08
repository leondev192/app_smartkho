import 'package:app_smartkho/ui/themes/colors.dart';
import 'package:app_smartkho/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final bool isError; // Add only a flag to indicate error state

  const CustomInputField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    this.prefixIcon,
    this.isError = false,
  });

  @override
  CustomInputFieldState createState() => CustomInputFieldState();
}

class CustomInputFieldState extends State<CustomInputField> {
  late FocusNode _focusNode;
  late bool _obscureText;
  bool _isFocused = false;
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    widget.controller.addListener(() {
      setState(() {
        _hasInput = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isError && !_hasInput && !_isFocused
        ? Colors.red
        : (_isFocused || _hasInput ? Colors.green : AppColors.borderColor);

    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.text5,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.iconColor,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
            color: borderColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
            color: borderColor,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
