import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/course_model.dart';
import '../../Model/lesson_model.dart';
import '../../ViewModel/course_lessons_viewmodel.dart';

class CourseLessonsPage extends StatelessWidget {
  final CourseModel course;

  const CourseLessonsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseLessonsViewModel(course: course),
      child: Consumer<CourseLessonsViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.lessons.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  course.title,
                  style: const TextStyle(color: Colors.white), // titre en blanc
                ),
              ),

                body: const Center(child: Text("No lessons available")),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                  course.title,
                  style: const TextStyle(color: Colors.white),
              ),
                backgroundColor: const Color(0xFF06112A)

            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: vm.lessons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lesson = vm.lessons[index];
                final accessible = vm.canAccessLesson(lesson);

                return GestureDetector(
                  onTap: accessible
                      ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Opening ${lesson.type.toUpperCase()}: ${lesson.title}'),
                      ),
                    );
                    // TODO: open video/pdf viewer using lesson.contentUrl
                  }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accessible ? Colors.white : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: accessible
                              ? const Color(0xFF06112A)
                              : Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          lesson.type == 'video'
                              ? Icons.play_circle_fill
                              : Icons.picture_as_pdf,
                          color: accessible ? Colors.purple : Colors.grey,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: accessible ? Colors.black : Colors.grey,
                                ),
                              ),
                              Text(
                                '${lesson.duration} min',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!accessible)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'PRO',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
