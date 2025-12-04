import 'package:flutter/material.dart';

class NavbarAccueilWidget extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onNavigate;

  const NavbarAccueilWidget({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF06112A),
      elevation: 2,
      titleSpacing: 0,
      title: Row(
        children: [
          // --- Logo gauche qui mène à Home ---
          GestureDetector(
            onTap: () => onNavigate('/'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset('assets/logo1.png', height: 50),
            ),
          ),

          // --- Menus centrés décalés à gauche (Blogs et About) ---
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _navItem(context, "Blogs", '/blog-public'),
                const SizedBox(width: 12),
                _navItem(context, "About", '/aboutpublic'),
              ],
            ),
          ),

          // --- Boutons login/signup à droite ---
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => onNavigate('/login'),
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () => onNavigate('/signup'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(70, 36),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF06112A),
                  ),
                  child: const Text('Sign up', overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Composant menu ---
  Widget _navItem(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () => onNavigate(route),
      child: Flexible(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
