import 'package:flutter/material.dart';
import '../../viewmodels/dashboard_viewmodel.dart';

class NewCourseModal extends StatelessWidget {
  final DashboardViewModel viewModel;

  const NewCourseModal({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Create New Course',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => viewModel.setShowNewCourseModal(false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInputField(
              'Course Title *',
              viewModel.newCourse['title'] ?? '',
                  (value) => viewModel.updateNewCourse('title', value),
            ),
            const SizedBox(height: 16),
            _buildInputField(
              'Category *',
              viewModel.newCourse['category'] ?? '',
                  (value) => viewModel.updateNewCourse('category', value),
            ),
            const SizedBox(height: 16),
            _buildTextArea(
              'Description',
              viewModel.newCourse['description'] ?? '',
                  (value) => viewModel.updateNewCourse('description', value),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => viewModel.setShowNewCourseModal(false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (viewModel.newCourse['title'].toString().isNotEmpty &&
                          viewModel.newCourse['category'].toString().isNotEmpty) {
                        viewModel.createCourse();
                      }
                    },
                    child: const Text('Create Course'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Ex: ${label.replaceAll(' *', '')}',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Describe what students will learn...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}

class NewLiveModal extends StatelessWidget {
  final DashboardViewModel viewModel;

  const NewLiveModal({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Schedule Live Session',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => viewModel.setShowNewLiveModal(false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInputField(
              'Session Title *',
              viewModel.newLive['title'] ?? '',
                  (value) => viewModel.updateNewLive('title', value),
            ),
            const SizedBox(height: 16),
            _buildDateTimeField(),
            const SizedBox(height: 16),
            _buildTextArea(
              'Description',
              viewModel.newLive['description'] ?? '',
                  (value) => viewModel.updateNewLive('description', value),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => viewModel.setShowNewLiveModal(false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (viewModel.newLive['title'].toString().isNotEmpty &&
                          viewModel.newLive['datetime'].toString().isNotEmpty) {
                        viewModel.createLiveSession();
                      }
                    },
                    child: const Text('Schedule Session'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Ex: ${label.replaceAll(' *', '')}',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date & Time *',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) => viewModel.updateNewLive('datetime', value),
          decoration: InputDecoration(
            hintText: 'Select date and time',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Describe what you\'ll cover in this session...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}