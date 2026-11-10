import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Стрім стану автентифікації для реактивного перемикання екранів
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // Вхід та автоматична реєстрація через Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Запуск вікна вибору акаунта Google на пристрої
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Якщо користувач скасував вибір (натиснув "Назад")
      if (googleUser == null) {
        return null;
      }

      // 2. Отримання деталей автентифікації від Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Створення облікових даних для Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Вхід у Firebase з отриманими обліковими даними
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Помилка авторизації через Google: $e';
    }
  }
  
  // Реєстрація нового користувача з ім'ям
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Вхід за email і паролем
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Відновлення пароля на email
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Оновлення пароля користувача
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw 'Ця дія вимагає повторного входу в акаунт перед зміною пароля.';
      }
      throw _handleAuthException(e);
    }
  }

  // Оновлення профілю (ім'я та фото з HTTPS-посилання)
  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    try {
      if (displayName != null) {
        await _auth.currentUser?.updateDisplayName(displayName);
      }
      if (photoUrl != null) {
        await _auth.currentUser?.updatePhotoURL(photoUrl);
      }
      await _auth.currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Вихід із системи
  Future<void> signOut() async {
    //await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Локалізація помилок Firebase у зрозумілі користувачу тексти
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'There is no user with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Wrong email or password.';
      case 'email-already-in-use':
        return 'This email is already taken.';
      case 'weak-password':
        return 'This password is too simple (at least 8 symbols).';
      case 'invalid-email':
        return 'Unsupported eMail format.';
      default:
        return e.message ?? 'Authentification error occured.';
    }
  }
  // Оновлення імені користувача
  Future<void> updateDisplayName(String newName) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(newName);
        await user.reload(); // Оновлює дані локального об'єкта User
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Перевірка, чи збігається введений пароль з дійсним паролем акаунта
  Future<bool> verifyCurrentPassword(String currentPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        throw 'The user is not authorised';
      }

      // Створюємо облікові дані на основі email користувача та введеного пароля
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      // Спроба повторної автентифікації
      await user.reauthenticateWithCredential(credential);
      return true; // Пароль правильний
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return false; // Неправильний пароль
      }
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Password verification error: $e';
    }
  }
}