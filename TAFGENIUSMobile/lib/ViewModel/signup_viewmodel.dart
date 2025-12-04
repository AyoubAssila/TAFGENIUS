import 'package:flutter/material.dart';
import '../../backend/auth/firebase_auth_service.dart';

class SignupViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool loading = false;
  String? errorMessage;

  /// Signup avec email/mot de passe et rôle
  Future<bool> signupWithEmail({
    required String fullName,
    required String email,
    required String password,
    String role = 'student', // rôle par défaut
  }) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // ⚠ utiliser les paramètres nommés et passer le rôle
      final user = await _authService.signup(
        email: email.trim(),
        password: password,
        fullName: fullName.trim(),
        role: role,
      );

      loading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      loading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Signup ou login avec Google
  Future<bool> signupWithGoogle() async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.signInWithGoogle();
      loading = false;
      notifyListeners();
      return result != null && result['user'] != null;
    } catch (e) {
      loading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
