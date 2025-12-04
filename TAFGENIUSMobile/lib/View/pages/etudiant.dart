// lib/View/pages/etudiant.dart
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'my_course.dart';
import 'history.dart';
import '../components/sidebar_widget.dart';
import '../components/navbar_widget.dart';
import '../../Model/user_model.dart';
import '../../Model/course_model.dart';

class EtudiantPage extends StatefulWidget {
  final UserModel user;
  final List<CourseModel> myCourses;
  final List<CourseModel> recommendedCourses;

  const EtudiantPage({
    super.key,
    required this.user,
    required this.myCourses,
    required this.recommendedCourses,
  });

  @override
  State<EtudiantPage> createState() => _EtudiantPageState();
}

class _EtudiantPageState extends State<EtudiantPage> {
  int selectedIndex = 0;

  late List<Widget> pages;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    pages = [
      const DashboardPage(),

      // ---------- FIX : MyCoursesPage reçoit les paramètres du widget ----------
      MyCoursesPage(
        user: widget.user,
        courses: widget.myCourses,
      ),

      HistoryView(userId: widget.user.id),
    ];
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _navigateTo(String route) {
    Navigator.pop(context);

    switch (route) {
      case '/dashboard':
        setState(() => selectedIndex = 0);
        break;
      case '/mycourses':
        setState(() => selectedIndex = 1);
        break;
      case '/history':
        setState(() => selectedIndex = 2);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NavbarWidget(
          onLogoTap: _openDrawer,
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF06112A),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF06112A)),
              child: Image.asset('assets/logo1.png', height: 60),
            ),
            Expanded(
              child: SidebarWidget(
                onSelectPage: _navigateTo,
                textColor: Colors.white,
                activeColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: pages[selectedIndex],
      ),
    );
  }
}
