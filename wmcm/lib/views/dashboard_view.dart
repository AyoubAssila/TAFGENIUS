import 'package:flutter/material.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import 'components/sidebar.dart';
import 'components/header.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/courses_tab.dart';
import 'tabs/messaging_tab.dart';
import 'tabs/live_sessions_tab.dart';
import 'tabs/analytics_tab.dart';
import 'tabs/settings_tab.dart';

class DashboardView extends StatefulWidget {
  final VoidCallback onNavigateToHome;

  const DashboardView({super.key, required this.onNavigateToHome});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardViewModel _viewModel = DashboardViewModel();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await Future.delayed(const Duration(seconds: 1));
    _viewModel.initializeMockData();
    setState(() {
      _isLoading = false;
    });
  }

  void _handleTabChange(String tab) {
    setState(() {
      _viewModel.setActiveTab(tab);
    });
  }

  Widget _buildActiveTab() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Loading Dashboard...',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    switch (_viewModel.activeTab) {
      case 'dashboard':
        return DashboardTab(viewModel: _viewModel);
      case 'courses':
        return CoursesTab(viewModel: _viewModel);
      case 'messaging':
        return MessagingTab(viewModel: _viewModel);
      case 'live':
        return LiveSessionsTab(viewModel: _viewModel);
      case 'analytics':
        return AnalyticsTab(viewModel: _viewModel);
      case 'settings':
        return SettingsTab(viewModel: _viewModel);
      default:
        return DashboardTab(viewModel: _viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Sidebar(
            activeTab: _viewModel.activeTab,
            onTabChange: _handleTabChange,
            onNavigateToHome: widget.onNavigateToHome,
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Header
                Header(activeTab: _viewModel.activeTab),
                // Content area
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildActiveTab(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}