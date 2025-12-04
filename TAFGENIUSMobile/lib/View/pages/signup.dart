import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/signup_viewmodel.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  String selectedRole = 'etudiant'; // rôle par défaut

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ChangeNotifierProvider(
          create: (_) => SignupViewModel(),
          child: Consumer<SignupViewModel>(
            builder: (context, vm, _) => Container(
              width: 400,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFFC084FC), Color(0xFF60A5FA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/logo2.png', height: 60),
                    const SizedBox(height: 10),
                    const Text(
                      "Become a Genius!",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Champs nom, email, mot de passe
                    _buildTextField(_nameController, "Full Name", Icons.person),
                    const SizedBox(height: 10),
                    _buildTextField(_emailController, "Email", Icons.email),
                    const SizedBox(height: 10),
                    _buildTextField(_passwordController, "Password", Icons.lock, obscureText: true),
                    const SizedBox(height: 10),
                    _buildTextField(_confirmController, "Confirm Password", Icons.lock, obscureText: true),
                    const SizedBox(height: 10),

                    // Dropdown rôle
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'etudiant', child: Text('Étudiant')),
                        DropdownMenuItem(value: 'webmaster_contenu', child: Text('Webmaster Contenu')),
                        DropdownMenuItem(value: 'webmaster_technique', child: Text('Webmaster Technique')),
                        DropdownMenuItem(value: 'commercial', child: Text('Commercial')),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => selectedRole = value);
                      },
                    ),
                    const SizedBox(height: 20),

                    // Bouton Sign Up
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: vm.loading
                            ? null
                            : () async {
                          if (_passwordController.text != _confirmController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Passwords do not match")),
                            );
                            return;
                          }

                          final success = await vm.signupWithEmail(
                            fullName: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            role: selectedRole,
                          );

                          if (success) {
                            // Redirection selon rôle
                            String route = '/etudiant';
                            switch (selectedRole) {
                              case 'webmaster_contenu':
                                route = '/admin-contenu';
                                break;
                              case 'webmaster_technique':
                                route = '/admin-technique';
                                break;
                              case 'commercial':
                                route = '/admin-commercial';
                                break;
                            }
                            Navigator.pushReplacementNamed(context, route);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(vm.errorMessage ?? "Signup failed")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF06112A),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: vm.loading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Sign Up with Google
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: vm.loading
                            ? null
                            : () async {
                          final success = await vm.signupWithGoogle();
                          if (success) {
                            String route = '/etudiant';
                            switch (selectedRole) {
                              case 'webmaster_contenu':
                                route = '/admin-contenu';
                                break;
                              case 'webmaster_technique':
                                route = '/admin-technique';
                                break;
                              case 'commercial':
                                route = '/admin-commercial';
                                break;
                            }
                            Navigator.pushReplacementNamed(context, route);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(vm.errorMessage ?? "Google signup failed")),
                            );
                          }
                        },
                        icon: Image.asset('assets/google_logo.png', height: 20, width: 20),
                        label: const Text("Sign Up with Google"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
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
    return TextField(
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
    );
  }
}
