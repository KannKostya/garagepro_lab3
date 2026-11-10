import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garagepro/screens/main_screen.dart';
import '../../repositories/auth_repository.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthRepository().authStateChanges,
      builder: (context, snapshot) {
        // Очікування відповіді від Firebase при запуску
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF0F2439)),
            ),
          );
        }

        // Користувач авторизований
        if (snapshot.hasData) {
          // Замініть на ваш наявний екран (наприклад, ServiceHistoryScreen() або MainTabScreen())
          return const MainScreen();
        }

        // Користувач не авторизований
        return const LoginScreen();
      },
    );
  }
}