import 'package:flutter/material.dart';

class NavbarCommercialWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoTap;

  const NavbarCommercialWidget({super.key, required this.onLogoTap});

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
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF06112A),
      elevation: 2,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // --- LOGO GAUCHE (ouvre le drawer) ---
          GestureDetector(
            onTap: onLogoTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset('assets/logo2.png', height: 45),
            ),
          ),

          // --- ESPACE FLEXIBLE AVANT LES MENUS ---
          const Spacer(),

          // --- MENUS CENTRÉS ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navItem(context, "Dashboard", '/admin-commercial'),
            ],
          ),

          // --- ESPACE FLEXIBLE APRÈS LES MENUS ---
          const Spacer(),

          // --- HOME JUSTE AVANT LE BADGE ---
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: _navItem(context, "Home", '/'),
          ),

          // --- BADGE COMMERCIAL AVEC MENU DÉROULANT ---
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _CommercialBadgeWithMenu(context: context),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CommercialBadgeWithMenu extends StatefulWidget {
  final BuildContext context;

  const _CommercialBadgeWithMenu({required this.context});

  @override
  State<_CommercialBadgeWithMenu> createState() => _CommercialBadgeWithMenuState();
}

class _CommercialBadgeWithMenuState extends State<_CommercialBadgeWithMenu> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              // Badge Commercial avec "C"
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _isHovered
                      ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 4,
                      spreadRadius: 1,
                    )
                  ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'C', // "C" pour Commercial
                    style: TextStyle(
                      color: const Color(0xFF06112A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Flèche dropdown
              Icon(
                Icons.arrow_drop_down,
                color: _isHovered ? Colors.white : Colors.white70,
                size: 20,
              ),
            ],
          ),
        ),
        onSelected: (value) {
          if (value == 'home') {
            _showLogoutDialog('go to home', '/');
          } else if (value == 'logout') {
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