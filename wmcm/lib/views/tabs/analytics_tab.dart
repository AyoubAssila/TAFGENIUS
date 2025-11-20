import 'package:flutter/material.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../components/analytics_chart.dart';

class AnalyticsTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const AnalyticsTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final stats = viewModel.getStats();

    return SingleChildScrollView(
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
              _buildStatCard('${stats['totalStudents']}', 'Total Students', Icons.people),
              _buildStatCard('${stats['totalCourses']}', 'Active Courses', Icons.school),
              _buildStatCard('${stats['activeLiveSessions']}', 'Live Sessions', Icons.live_tv),
              _buildStatCard('${stats['totalThreads']}', 'Discussions', Icons.forum),
            ],
          ),
          const SizedBox(height: 24),

          // Charts
          AnalyticsChart(
            data: viewModel.analyticsData['students']!,
            type: 'line',
            title: 'Enrollment Growth',
          ),
          const SizedBox(height: 16),
          AnalyticsChart(
            data: viewModel.analyticsData['engagement']!,
            type: 'bar',
            title: 'Weekly Engagement',
          ),
          const SizedBox(height: 16),
          AnalyticsChart(
            data: viewModel.analyticsData['courses']!,
            type: 'bar',
            title: 'Course Popularity',
          ),

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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildMetricCard('87%', 'Completion Rate'),
                      _buildMetricCard('4.8/5', 'Student Rating'),
                      _buildMetricCard('92%', 'Satisfaction'),
                      _buildMetricCard('15min', 'Avg Response'),
                      _buildMetricCard('78%', 'Engagement'),
                      _buildMetricCard('95%', 'Retention'),
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

  Widget _buildMetricCard(String value, String label) {
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