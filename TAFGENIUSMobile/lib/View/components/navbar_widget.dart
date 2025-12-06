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
          GestureDetector(
            onTap: onLogoTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset('assets/logo2.png', height: 45),
            ),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 👉 HOME AVEC CONFIRMATION
              _navItemHome(context),

              const SizedBox(width: 30),
              _navItem(context, "Blogs", '/blog-etudiant'),
              const SizedBox(width: 30),
              _navItem(context, "About", '/about'),
            ],
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: PopupMenuButton(
              icon: const Icon(Icons.person, color: Colors.white, size: 28),
              onSelected: (value) async {
                if (value == 'edit') {
                  Navigator.pushNamed(context, '/edit-profile');
                }

                else if (value == 'logout') {
                  // 👉 CONFIRMATION LOGOUT
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Logout"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    Navigator.pushNamed(context, '/login');
                  }
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

  // 🔥 VERSION NEUTRE (inchangée) des autres items
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

  // 🔥 SPECIAL : HOME AVEC CONFIRMATION
  Widget _navItemHome(BuildContext context) {
    return InkWell(
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Go to Home?"),
            content:
            const Text("Do you want to leave this page and return to Home?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Go"),
              ),
            ],
          ),
        );

        if (confirm == true) {
          Navigator.pushNamed(context, '/');
        }
      },
      child: const Text(
        "Home",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
