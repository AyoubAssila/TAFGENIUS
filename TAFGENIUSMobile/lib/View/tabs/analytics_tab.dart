import 'package:flutter/material.dart';
import '../../ViewModel/dashboard_webcontenu_viewmodel.dart';
import '../components/analytics_chart.dart';

class AnalyticsTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const AnalyticsTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final stats = viewModel.getStats();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Overview Stats
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard(
                  '${stats['totalStudents']}', 'Total Students', Icons.people),
              _buildStatCard(
                  '${stats['totalCourses']}', 'Active Courses', Icons.school),
              _buildStatCard('${stats['activeLiveSessions']}',
                  'Live Sessions', Icons.live_tv),
              _buildStatCard(
                  '${stats['totalThreads']}', 'Discussions', Icons.forum),
            ],
          ),
          const SizedBox(height: 24),

          // Charts
          if (viewModel.analyticsData['students'] != null)
            AnalyticsChart(
              data: viewModel.analyticsData['students']!,
              type: 'line',
              title: 'Enrollment Growth',
            ),
          const SizedBox(height: 16),
          if (viewModel.analyticsData['engagement'] != null)
            AnalyticsChart(
              data: viewModel.analyticsData['engagement']!,
              type: 'bar',
              title: 'Weekly Engagement',
            ),
          const SizedBox(height: 16),
          if (viewModel.analyticsData['courses'] != null)
            AnalyticsChart(
              data: viewModel.analyticsData['courses']!,
              type: 'bar',
              title: 'Course Popularity',
            ),

          const SizedBox(height: 24),
          // Performance Metrics
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Metrics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: const [
                      _MetricCard(value: '87%', label: 'Completion Rate'),
                      _MetricCard(value: '4.8/5', label: 'Student Rating'),
                      _MetricCard(value: '92%', label: 'Satisfaction'),
                      _MetricCard(value: '15min', label: 'Avg Response'),
                      _MetricCard(value: '78%', label: 'Engagement'),
                      _MetricCard(value: '95%', label: 'Retention'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Pour réutiliser MetricCard facilement
class _MetricCard extends StatelessWidget {
  final String value;
  final String label;

  const _MetricCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
