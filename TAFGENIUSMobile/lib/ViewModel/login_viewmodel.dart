import 'package:flutter/material.dart';
import '../../backend/auth/firebase_auth_service.dart';
import '../../Model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  bool loading = false;
  String? errorMessage;
  UserModel? loggedUser;

  /// Connexion avec email et mot de passe - CORRIGÉ
  Future<UserModel?> loginWithEmail({required String email, required String password}) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      print("📱 Login pour: $email");

      final result = await _authService.login(
        email: email.trim(),
        password: password,
      );

      final user = result['user'];
      final role = result['role'] as String;
      final userData = result['userData'] as Map<String, dynamic>;

      print("✅ Auth réussie!");
      print("   Rôle: $role");

      // CRÉER USERMODEL AVEC LE BON RÔLE
      loggedUser = UserModel(
        id: user.uid,
        name: userData['name']?.toString() ?? 'Utilisateur',
        email: user.email ?? email,
        role: role, // ← RÔLE CORRECT ICI
        createdAt: userData['createdAt']?.toDate() ?? DateTime.now(),
      );

      print("🎯 Rôle final dans UserModel: ${loggedUser!.role}");
      print("📍 Redirection vers: ${getRouteForRole()}");

      loading = false;
      notifyListeners();
      return loggedUser;

    } catch (e) {
      loading = false;
      errorMessage = e.toString();

      if (e.toString().contains('Email ou mot de passe')) {
        errorMessage = "Email ou mot de passe incorrect";
      } else if (e.toString().contains('Aucun compte')) {
        errorMessage = "Aucun compte avec cet email";
      } else if (e.toString().contains('non autorisé')) {
        errorMessage = "Votre rôle n'est pas autorisé";
      } else {
        errorMessage = "Erreur de connexion";
      }

      print("❌ Erreur: $errorMessage");
      notifyListeners();
      return null;
    }
  }

  /// Connexion avec Google
  Future<UserModel?> loginWithGoogle() async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.signInWithGoogle();
      final user = result['user'];
      final role = result['role'] as String;

      loggedUser = UserModel(
        id: user.uid,
        name: user.displayName ?? 'Utilisateur Google',
        email: user.email ?? '',
        role: role,
        createdAt: DateTime.now(),
      );

      loading = false;
      notifyListeners();
      return loggedUser;

    } catch (e) {
      loading = false;
      errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// REDIRECTION SELON LE RÔLE - CORRIGÉ
  String getRouteForRole() {
    if (loggedUser == null) return '/login';

    final role = loggedUser!.role.toLowerCase().trim();
    print("🎯 getRouteForRole: '$role'");

    if (role == 'content_webmaster') {
      return '/admin-contenu';
    } else if (role == 'technical_webmaster') {
      return '/admin-technique/dashboard';
    } else if (role == 'commercial') {
      return '/admin-commercial';
    } else if (role == 'student') {
      return '/dashboard';
    } else {
      print("⚠️ Rôle inconnu: '$role', redirection étudiant par défaut");
      return '/dashboard';
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}