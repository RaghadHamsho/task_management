import 'package:flutter/material.dart';
import 'package:task_management_system/app_theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.isAuth = false,
    this.controller,
    this.validator, // new
  });

  final String hint;
  final IconData? icon;
  final bool isPassword;
  final bool isAuth;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // new

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;
  bool isFocused = false;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusColor = Color(0xFF009988);

    return TextFormField( // Changed from TextField
      controller: widget.controller,
      focusNode: focusNode,
      obscureText: widget.isPassword ? obscure : false,
      style: TextStyle(fontSize: 14, color: colors(context).textColor),
      validator: widget.validator, // added validator
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: 12),
        filled: widget.isAuth,
        fillColor: colors(context).backgroundColor,
        prefixIcon: widget.icon != null
            ? Icon(
          widget.icon,
          color: isFocused ? focusColor : Colors.grey,
        )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.isAuth
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: widget.isAuth
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: focusColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
