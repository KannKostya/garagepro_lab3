import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PasswordInputField({
    super.key,
    this.controller,
    this.validator,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  // Змінна стану: чи прихований пароль (за замовчуванням true)
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xFF0F2439),
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5, // Робить крапки пароля акуратними та розрідженими
      ),
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE0E3E6), // Сірий колір підкладки як на скриншоті
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintText: '••••••••••••••••',
        hintStyle: const TextStyle(
          color: Color(0xFF94A3B8),
          letterSpacing: 2.0,
        ),
        // Іконка замка зліва
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 14, right: 10),
          child: Icon(
            Icons.lock_outline_rounded,
            color: Color(0xFF74777D),
            size: 22,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
          minHeight: 24,
        ),
        // Кнопка перемикання видимості пароля справа
        suffixIcon: IconButton(
          splashRadius: 20,
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined // Перекреслене око
                : Icons.visibility_outlined,     // Відкрите око
            color: const Color(0xFF74777D),
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        // Заокруглені кути без контурної лінії
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}