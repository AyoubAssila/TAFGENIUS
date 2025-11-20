import 'package:flutter/material.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../components/modals.dart';

class DashboardTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const DashboardTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final stats = viewModel.getStats();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard('${stats['totalStudents']}', 'Total Students'),
              _buildStatCard('${stats['totalCourses']}', 'Courses Created'),
              _buildStatCard('${stats['totalThreads']}', 'Discussions'),
              _buildStatCard('${viewModel.liveSessions.length}', 'Live Sessions'),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => viewModel.setShowNewCourseModal(true),
                          icon: const Icon(Icons.add),
                          label: const Text('New Course'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => viewModel.setShowNewLiveModal(true),
                          icon: const Icon(Icons.live_tv),
                          label: const Text('Live Session'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Recent Courses
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Courses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (viewModel.courses.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No courses yet. Create your first course!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    ...viewModel.courses.take(3).map((course) => ListTile(
                      leading: const Icon(Icons.school, color: Colors.blue),
                      title: Text(course.title),
                      subtitle: Text('${course.students} students • ${course.status}'),
                      trailing: Chip(
                        label: Text(course.category),
                        backgroundColor: Colors.grey[100],
                      ),
                    )),
                ],
              ),
            ),
          ),

          // Modals
          if (viewModel.showNewCourseModal)
            NewCourseModal(viewModel: viewModel),
          if (viewModel.showNewLiveModal)
            NewLiveModal(viewModel: viewModel),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
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