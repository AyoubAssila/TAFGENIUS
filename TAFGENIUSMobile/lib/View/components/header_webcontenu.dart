import 'package:flutter/material.dart';

// =================== HEADER ===================
class HeaderWebContenu extends StatelessWidget {
  final String activeTab;
  final VoidCallback onLogoTap;

  const HeaderWebContenu({
    super.key,
    required this.activeTab,
    required this.onLogoTap,
  });

  void _showConfirmationDialog(BuildContext context, String action, String route) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06112A),
            ),
          ),
          content: Text('Are you sure you want to $action?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  route,
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF06112A),
                foregroundColor: Colors.white,
              ),
              child: Text(action == 'go to home' ? 'Go Home' : 'Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _menuItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        if (title == 'Home') {
          _showConfirmationDialog(context, 'go to home', '/');
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      margin: const EdgeInsets.only(top: 40), // <- décale la navbar vers le bas
      decoration: BoxDecoration(
        color: const Color(0xFF06112A),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: onLogoTap,
            child: Image.asset("assets/logo2.png", height: 35),
          ),

          const SizedBox(width: 20),

          // Supprimé : titre dynamique
          const Spacer(),

          // Menu items
          Row(
            children: [
              _menuItem(context, 'Home', '/'),
              const SizedBox(width: 20),
              _menuItem(context, 'Blogs', '/blog-contenu'),
            ],
          ),

          const SizedBox(width: 20),

          // Badge Content Manager réduit
          _ContentManagerBadgeWithMenu(context: context),
        ],
      ),
    );
  }
}

// =================== BADGE ===================
class _ContentManagerBadgeWithMenu extends StatefulWidget {
  final BuildContext context;

  const _ContentManagerBadgeWithMenu({required this.context});

  @override
  State<_ContentManagerBadgeWithMenu> createState() => _ContentManagerBadgeWithMenuState();
}

class _ContentManagerBadgeWithMenuState extends State<_ContentManagerBadgeWithMenu> {
  bool _isHovered = false;

  void _showLogoutDialog(String action, String route) {
    showDialog(
      context: widget.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06112A),
            ),
          ),
          content: Text('Are you sure you want to $action?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  route,
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF06112A),
                foregroundColor: Colors.white,
              ),
              child: Text(action == 'go to home' ? 'Go Home' : 'Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.15)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'CM',
                    style: TextStyle(
                      color: Color(0xFF06112A),
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Content Manager',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'Administrator',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_drop_down,
                color: _isHovered ? Colors.white : Colors.white70,
                size: 14,
              ),
            ],
          ),
        ),
        onSelected: (value) {
          if (value == 'logout') {
            _showLogoutDialog('log out', '/login');
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem<String>(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, size: 20, color: Color(0xFF06112A)),
                SizedBox(width: 10),
                Text('Log Out'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
