import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;
  final VoidCallback onNavigateToHome;

  const Sidebar({
    super.key,
    required this.activeTab,
    required this.onTabChange,
    required this.onNavigateToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.blue[700],
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.white, size: 32),
                const SizedBox(width: 10),
                Text(
                  'AFTGENIUS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Menu items
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem('dashboard', 'Dashboard', Icons.dashboard),
                _buildMenuItem('courses', 'Manage Courses', Icons.school),
                _buildMenuItem('messaging', 'Messaging', Icons.message),
                _buildMenuItem('live', 'Live Sessions', Icons.live_tv),
                _buildMenuItem('analytics', 'Analytics', Icons.analytics),
                _buildMenuItem('settings', 'Settings', Icons.settings),
                const Divider(color: Colors.white54, height: 40),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text(
                    'Back to Site',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: onNavigateToHome,
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'AFTGENIUS Platform',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '© 2024 All rights reserved',
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
    );
  }

  Widget _buildMenuItem(String id, String label, IconData icon) {
    final isActive = activeTab == id;
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
      onTap: () => onTabChange(id),
    );
  }
}