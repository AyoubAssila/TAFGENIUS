// lib/View/components/sidebar_widget.dart
import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final Function(String route) onSelectPage;
  final Color textColor;
  final Color activeColor;

  const SidebarWidget({
    super.key,
    required this.onSelectPage,
    this.textColor = Colors.white,
    this.activeColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Dashboard', 'route': '/dashboard', 'icon': Icons.dashboard},
      {'name': 'My Courses', 'route': '/mycourses', 'icon': Icons.book},
      {'name': 'History', 'route': '/history', 'icon': Icons.history},
    ];

    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      color: const Color(0xFF06112A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF06112A)),
            child: Image(
              image: AssetImage('assets/logo1.png'),
              height: 20,
            ),
          ),
          ...items.map((item) {
            final bool isActive = currentRoute == item['route'];
            return ListTile(
              leading: Icon(item['icon'] as IconData,
                  color: isActive ? activeColor : textColor),
              title: Text(item['name'] as String,
                  style: TextStyle(
                      color: isActive ? activeColor : textColor,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
              tileColor: isActive ? Colors.white24 : null,
              onTap: () => onSelectPage(item['route'] as String),
            );
          }).toList(),
        ],
      ),
    );
  }
}
