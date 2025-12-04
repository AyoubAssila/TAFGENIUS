import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/course_model.dart';
import '../../Model/lesson_model.dart';
import '../../ViewModel/course_detail_viewmodel.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseModel course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CourseDetailViewModel>(context);

    if (!viewModel.hasAccess) {
      return Scaffold(
        appBar: AppBar(title: Text(course.title)),
        body: const Center(
          child: Text(
            "You don’t have access to this course.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Description: ${course.description}"),
              Text("Instructor ID: ${course.teacherId}"),
              Text("Category: ${course.category}"),
              Text("Price: ${course.price.toStringAsFixed(2)}"),
              const SizedBox(height: 16),
              LinearProgressIndicator(value: viewModel.progressValue),
              const SizedBox(height: 4),
              Text("${(viewModel.progressValue * 100).round()}% completed"),
              const SizedBox(height: 24),
              const Text("Lessons",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...viewModel.lessons.map((lesson) => ListTile(
                title: Text(lesson.title),
                subtitle: Text(
                    "Type: ${lesson.type} | Duration: ${lesson.duration} sec"),
                trailing: Icon(
                  viewModel.user?.progress[course.id]?.completedLessonIds
                      .contains(lesson.id) ??
                      false
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: Colors.green,
                ),
                onTap: () => viewModel.markLessonCompleted(lesson.id),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
