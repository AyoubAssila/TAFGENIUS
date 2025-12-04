import 'package:flutter/material.dart';

class SidebarWebcontenu extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;
  final VoidCallback onNavigateToHome;

  const SidebarWebcontenu({
    super.key,
    required this.activeTab,
    required this.onTabChange,
    required this.onNavigateToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF06112A),
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  Image.asset('assets/logo1.png', height: 60),
                ],
              ),
            ),

            // Menu principal
            Expanded(
              child: ListView(
                children: [
                  _menuItem(context, "dashboard", "Dashboard", Icons.dashboard),
                  _menuItem(context, "courses", "Manage Courses", Icons.school),
                  _menuItem(context, "messaging", "Messaging", Icons.message),
                  _menuItem(context, "live", "Live Sessions", Icons.live_tv),
                  _menuItem(context, "analytics", "Analytics", Icons.analytics),
                  _menuItem(context, "settings", "Settings", Icons.settings),

                  const Divider(color: Colors.white54, height: 40),

                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: const Text(
                      "Back to Site",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Fermer le drawer d'abord, puis naviguer
                      Navigator.pop(context);
                      onNavigateToHome();
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "TAFGENIUS Platform",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "© 2024 All rights reserved",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String id, String label,
      IconData icon) {
    final isActive = id == activeTab;

    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.white.withOpacity(0.15) : null,
      onTap: () {
        print('🎯 Menu clicked: $id');
        // Mettre à jour l'onglet
        onTabChange(id);
        // Fermer le drawer
        Navigator.pop(context);
      },
    );
  }
}