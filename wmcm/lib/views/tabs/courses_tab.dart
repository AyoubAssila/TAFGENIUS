import 'package:flutter/material.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import '../../models/course.dart'; // AJOUTER CET IMPORT
import '../components/modals.dart';

class CoursesTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const CoursesTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final publishedCount = viewModel.courses.where((c) => c.status == 'published').length;
    final draftCount = viewModel.courses.where((c) => c.status == 'draft').length;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Course Management',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.setShowNewCourseModal(true),
                    icon: const Icon(Icons.add),
                    label: const Text('New Course'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '$publishedCount published • $draftCount drafts • ${viewModel.courses.length} total',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              if (viewModel.courses.isEmpty)
                _buildEmptyState()
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: viewModel.courses.length,
                  itemBuilder: (context, index) => _buildCourseCard(viewModel.courses[index]),
                ),
            ],
          ),
        ),

        // Modals
        if (viewModel.showNewCourseModal)
          NewCourseModal(viewModel: viewModel),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!), // CORRIGÉ: retirer BorderStyle.dashed
      ),
      child: Column(
        children: [
          const Icon(Icons.school, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No Courses Yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create your first course to get started',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => viewModel.setShowNewCourseModal(true),
            child: const Text('Create Your First Course'),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    course.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: course.status == 'published'
                        ? Colors.green[50]
                        : Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    course.status == 'published' ? 'Published' : 'Draft',
                    style: TextStyle(
                      color: course.status == 'published'
                          ? Colors.green[700]
                          : Colors.orange[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                course.category,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${course.students} students',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              'Updated: ${course.lastUpdated}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Edit course functionality
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (course.status == 'published') {
                        // Unpublish functionality
                      } else {
                        // Publish functionality
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: course.status == 'published'
                          ? Colors.orange
                          : Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      course.status == 'published' ? 'Unpublish' : 'Publish',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}