import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24), // ефект закруглених кутів телефона
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 390, // ширина екрана телефона
                maxHeight: 948,
              ),
              child: child,
            ),
          ),
        );
      },
      title: 'Car Maintenance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Генерація палітри Android на основі базового кольору
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        // Стандартні закруглення карток та полів у стилі Android
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}