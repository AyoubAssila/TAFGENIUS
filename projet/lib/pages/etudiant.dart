import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'courses.dart';
import 'history.dart';
import 'editprofile.dart';


class EtudiantPage extends StatefulWidget {
  const EtudiantPage({super.key});

  @override
  State<EtudiantPage> createState() => _EtudiantPageState();
}

class _EtudiantPageState extends State<EtudiantPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const MyCoursesPage(),
    const HistoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          "TAFGenius",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<int>(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
              onSelected: (value) {
                if (value == 1) {
                  // Navigue vers EditProfilePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );

                } else if (value == 2) {
                  // Log Out
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged out")),
                  );
                  // Ici tu peux appeler la fonction de logout réelle
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Edit Profile"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),


      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'My Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('TAFGenius', style: TextStyle(color: Colors.white, fontSize: 30)),
          ),
          ListTile(leading: const Icon(Icons.home), title: const Text('Home'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.article), title: const Text('Blogs'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.info), title: const Text('About'), onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
