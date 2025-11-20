import 'package:flutter/material.dart';
import '../views/landing_page.dart';
import '../views/dashboard_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String _currentPage = 'home';

  void _navigateToDashboard() {
    setState(() {
      _currentPage = 'dashboard';
    });
  }

  void _navigateToHome() {
    setState(() {
      _currentPage = 'home';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage == 'home'
          ? LandingPage(onNavigateToDashboard: _navigateToDashboard)
          : DashboardView(onNavigateToHome: _navigateToHome),
    );
  }
}