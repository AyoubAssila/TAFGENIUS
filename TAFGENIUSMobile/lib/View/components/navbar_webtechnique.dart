import 'package:flutter/material.dart';

class NavbarWebTechnique extends StatelessWidget {
  final VoidCallback onLogoTap;

  const NavbarWebTechnique({
    super.key,
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

  Widget _navItem(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () {
        if (text == "Home") {
          _showConfirmationDialog(context, 'go to home', '/');
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF06112A),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onLogoTap,
              child: Row(
                children: [
                  Image.asset("assets/logo2.png", height: 35),
                ],
              ),
            ),

            const Spacer(),

            Row(
              children: [
                _navItem(context, "Home", '/'),
              ],
            ),

            _TechnicalManagerBadgeWithMenu(context: context),
          ],
        ),
      ),
    );
  }
}

/// BADGE (Version réduite)
class _TechnicalManagerBadgeWithMenu extends StatefulWidget {
  final BuildContext context;

  const _TechnicalManagerBadgeWithMenu({required this.context});

  @override
  State<_TechnicalManagerBadgeWithMenu> createState() =>
      _TechnicalManagerBadgeWithMenuState();
}

class _TechnicalManagerBadgeWithMenuState
    extends State<_TechnicalManagerBadgeWithMenu> {
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
          padding: const EdgeInsets.all(6),
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
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Center(
                  child: Text(
                    'TM',
                    style: TextStyle(
                      color: Color(0xFF06112A),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Technical Manager',
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
                size: 18,
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
                Icon(Icons.logout, size: 18, color: Color(0xFF06112A)),
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
