import 'package:flutter/material.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF06112A), // ← TOUT LE BACKGROUND EN 0xFF06112A
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              color: const Color(0xFF06112A),
              child: Center(
                child: Image.asset('assets/logo1.png', height: 60), // ← LOGO1.PNG À LA PLACE DE TAFGENIUS
              ),
            ),
            const SizedBox(height: 20),
            // Menu items - CORRIGEZ LES ROUTES
            ListTile(
              title: const Text(
                "Dashboard",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/admin-technique/dashboard");
              },
            ),
            ListTile(
              title: const Text(
                "Users",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/admin-technique/users");
              },
            ),
            ListTile(
              title: const Text(
                "Logs",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/admin-technique/logs");
              },
            ),
          ],
        ),
      ),
    );
  }
}