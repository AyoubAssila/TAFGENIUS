import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoTap;

  const NavbarWidget({super.key, required this.onLogoTap});

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
              _navItem(context, "Home", '/'),      // renvoie à la page publique Home
              const SizedBox(width: 30),
              _navItem(context, "Blogs", '/blog-etudiant'), // blog étudiant
              const SizedBox(width: 30),
              _navItem(context, "About", '/about'), // about étudiant
            ],
          )
          ,

          // --- ESPACE FLEXIBLE APRÈS LES MENUS ---
          const Spacer(),

          // --- ICON UTILISATEUR À DROITE ---
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: PopupMenuButton(
              icon: const Icon(Icons.person, color: Colors.white, size: 28),
              onSelected: (value) {
                if (value == 'edit') {
                  Navigator.pushNamed(context, '/edit-profile');
                } else if (value == 'logout') {
                  Navigator.pushNamed(context, '/login');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit Profile'),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
