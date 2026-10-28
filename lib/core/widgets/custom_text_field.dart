import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Color bgColor;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.bgColor = const Color(0xFFE0E3E6),
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}
class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.bgColor,
        hoverColor: widget.bgColor,
        hintText: widget.label,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF9CA3AF),
        ),

        prefixIcon: widget.prefixIcon != null
        ? Icon(
            widget.prefixIcon,
            size: 20,
            color: const Color(0xFF64748B),
          )
        : null,
        
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF9CA3AF),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}