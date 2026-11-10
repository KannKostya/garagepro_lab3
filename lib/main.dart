import 'dart:ui';
import 'package:flutter/material.dart';
//import 'screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';
import 'screens/auth/auth_gate.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Ініціалізація Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ініціалізація Sentry, яка огортає запуск Flutter додатку
  await SentryFlutter.init(
    (options) {
      // Вставте сюди ваш DSN, отриманий на сайті Sentry:
      options.dsn = 'https://b3823d9c88f190f338683f50e48b555b@o4512409438191616.ingest.de.sentry.io/4512409453658192';
      
      // Встановлюємо 100% збору подій для тестування (1.0 = 100%)
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Об'єкти для аналітики та відстеження навігації
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
      navigatorObservers: [observer],
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
      home: const AuthGate(),
    );
  }
}