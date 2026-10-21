import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Color bgColor;

  const CustomTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.bgColor = const Color(0xFFE0E3E6),
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}
class _CustomTextFieldState extends State<CustomTextField> {
  // Локальна змінна для відстеження приховування тексту
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Початкове значення береться з параметра віджета
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      // Якщо це пароль — використовуємо поточний стан, інакше текст завжди відкритий
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.bgColor,
        hintText: widget.label,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF9CA3AF),
        ),
        prefixIcon: Icon(widget.prefixIcon, color: const Color(0xFF9CA3AF)),
        // Якщо isPassword == true — показуємо кнопку-око, інакше суфікс порожній
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
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}