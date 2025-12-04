import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/course_model.dart';
import '../../Model/user_model.dart';
import '../components/course_card.dart';
import 'course_detail.dart';
import '../../ViewModel/course_detail_viewmodel.dart';

class MyCoursesPage extends StatefulWidget {
  final UserModel user;
  final List<CourseModel> courses; // tous les cours disponibles

  const MyCoursesPage({super.key, required this.user, required this.courses});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  String search = "";

  List<CourseModel> get filteredCourses => widget.courses
      .where((c) => widget.user.purchasedCourses.contains(c.id))
      .where((c) => c.title.toLowerCase().contains(search.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(title: const Text("My Courses")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search courses...",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => search = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  final progress = widget.user.progress[course.id]?.percent ?? 0;

                  return CourseCard(
                    course: course,
                    progress: progress,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => CourseDetailViewModel(
                                course: course, user: widget.user),
                            child: CourseDetailPage(course: course),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
