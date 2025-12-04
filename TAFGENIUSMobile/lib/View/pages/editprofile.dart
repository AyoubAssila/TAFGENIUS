import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/editprofile_viewmodel.dart';
import '../../Model/user_model.dart';

class EditProfilePage extends StatelessWidget {
  final UserModel user;

  const EditProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(user: user),
      child: Consumer<EditProfileViewModel>(
        builder: (context, vm, _) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 450,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFC084FC), Color(0xFF60A5FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    Column(
                      children: const [
                        Icon(Icons.person, size: 60, color: Colors.white),
                        SizedBox(height: 10),
                        Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),

                    // MESSAGE
                    if (vm.message.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: vm.message.contains("success")
                              ? const Color(0xFFD4EDDA)
                              : const Color(0xFFF8D7DA),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          vm.message,
                          style: TextStyle(
                            color: vm.message.contains("success")
                                ? const Color(0xFF155724)
                                : const Color(0xFF721C24),
                          ),
                        ),
                      ),

                    // FORMULAIRE style Login/Signup
                    Column(
                      children: [
                        _buildTextField(vm.usernameController, "Username", Icons.person),
                        _buildTextField(vm.emailController, "Email", Icons.email),
                        _buildTextField(vm.passwordController, "New Password", Icons.lock, obscureText: true),
                        _buildTextField(vm.confirmPasswordController, "Confirm Password", Icons.lock, obscureText: true),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: vm.saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF06112A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Save Changes",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}
