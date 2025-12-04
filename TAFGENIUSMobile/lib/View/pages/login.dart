import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(20.0),
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
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // ===== FORM =====
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  decoration: inputDecoration.copyWith(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: inputDecoration.copyWith(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),

                Consumer<LoginViewModel>(
                  builder: (context, vm, child) => Column(
                    children: [
                      if (vm.loading)
                        const CircularProgressIndicator()
                      else
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Veuillez remplir tous les champs")),
                                );
                                return;
                              }

                              final user = await vm.loginWithEmail(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );

                              if (user != null) {
                                final route = vm.getRouteForRole();
                                Navigator.pushReplacementNamed(context, route);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(vm.errorMessage ?? "Login failed"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF06112A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Log In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      if (vm.errorMessage != null && !vm.loading)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            vm.errorMessage!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Consumer<LoginViewModel>(
                  builder: (context, vm, child) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: vm.loading
                          ? null
                          : () async {
                        FocusScope.of(context).unfocus();
                        final user = await vm.loginWithGoogle();
                        if (user != null) {
                          final route = vm.getRouteForRole();
                          Navigator.pushReplacementNamed(context, route);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(vm.errorMessage ?? "Google login failed"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      icon: Image.asset('assets/google_logo.png', height: 20, width: 20),
                      label: const Text('Login with Google'),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
