import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/user_model.dart';

class EditProfileViewModel extends ChangeNotifier {
  UserModel user;

  // Contrôleurs de texte pour le formulaire
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  String message = '';

  EditProfileViewModel({required this.user}) {
    usernameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController(text: user.password);
    confirmPasswordController = TextEditingController();
  }

  // Mettre à jour les valeurs dans le modèle à partir des controllers
  void updateUserFromControllers() {
    user.name = usernameController.text.trim();
    user.email = emailController.text.trim();
    user.password = passwordController.text;
  }

  bool _validate() {
    updateUserFromControllers();

    if (user.name.isEmpty) {
      message = "Username cannot be empty";
      return false;
    }

    if (!user.email.contains("@")) {
      message = "Invalid email format";
      return false;
    }

    if (user.password.isNotEmpty && user.password.length < 6) {
      message = "Password must be at least 6 characters";
      return false;
    }

    if (user.password != confirmPasswordController.text) {
      message = "Passwords do not match";
      return false;
    }

    return true;
  }

  Future<void> saveChanges() async {
    if (!_validate()) {
      notifyListeners();
      return;
    }

    message = "Saving...";
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update(user.toMap());

      message = "Profile updated successfully!";
    } catch (e) {
      message = "Error updating profile: $e";
    }

    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
