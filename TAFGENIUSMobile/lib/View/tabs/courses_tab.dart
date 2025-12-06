import 'package:flutter/material.dart';
import '../../ViewModel/dashboard_webcontenu_viewmodel.dart';
import '../../Model/course_model.dart';
import '../components/modals.dart';

class CoursesTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const CoursesTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final total = viewModel.courses.length;

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
                '$total courses total',
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
                  itemBuilder: (context, index) =>
                      _buildCourseCard(viewModel.courses[index]),
                ),
            ],
          ),
        ),

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
        border: Border.all(color: Colors.grey[300]!),
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

  Widget _buildCourseCard(CourseModel course) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(course.icons, style: const TextStyle(fontSize: 30)),
                const SizedBox(width: 8),
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
              ],
            ),

            const SizedBox(height: 12),

            Text(
              'Lessons: ${course.lessons.length}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),

            Text(
              'Price: ${course.price.toStringAsFixed(2)} TND',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),

            Text(
              'Instructor: ${course.teacherId.isEmpty ? "Unknown" : course.teacherId}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),

            Text(
              'Category: ${course.category.isEmpty ? "Not defined" : course.category}',
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
                      // Open course details
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Open',
                      style: TextStyle(fontSize: 12),
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
