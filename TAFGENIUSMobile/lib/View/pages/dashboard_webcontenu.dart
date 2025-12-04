import 'package:flutter/material.dart';
import '../../ViewModel/dashboard_webcontenu_viewmodel.dart';
import '../tabs/dashboard_tab.dart';
import '../tabs/courses_tab.dart';
import '../tabs/messaging_tab.dart';
import '../tabs/live_sessions_tab.dart';
import '../tabs/analytics_tab.dart';


class DashboardView extends StatefulWidget {
  final VoidCallback onNavigateToHome;
  final String activeTab;

  const DashboardView({
    super.key,
    required this.onNavigateToHome,
    required this.activeTab,
  });

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

  @override
  void didUpdateWidget(DashboardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeTab != widget.activeTab) {
      debugPrint('🔄 Tab updated to: ${widget.activeTab}');
    }
  }

  void _initializeData() async {
    await _viewModel.loadAllData();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildActiveTab() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    switch (widget.activeTab) {
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
      default:
        return DashboardTab(viewModel: _viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildActiveTab();
  }
}
