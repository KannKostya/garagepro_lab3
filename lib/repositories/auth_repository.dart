import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Стрім стану автентифікації для реактивного перемикання екранів
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;
  
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

  // Оновлення профілю
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
        await user.reload();
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

      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return false;
      }
      throw _handleAuthException(e);
    } catch (e) {
      throw 'Password verification error: $e';
    }
  }
}