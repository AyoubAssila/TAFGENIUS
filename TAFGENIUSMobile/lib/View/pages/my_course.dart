import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/course_model.dart';
import '../../Model/user_model.dart';
import 'course_lessons.dart';
import '../../ViewModel/courses_viewmodel.dart';

class MyCoursesPage extends StatefulWidget {
  final UserModel user;

  const MyCoursesPage({super.key, required this.user});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final coursesVM = Provider.of<CoursesViewModel>(context);

    // Cours achetés
    List<CourseModel> myCourses = coursesVM.myCourses(widget.user)
        .where((c) => c.title.toLowerCase().contains(search.toLowerCase()))
        .toList();

    // Cours recommandés
    List<CourseModel> recommendedCourses = coursesVM.recommendedCourses(widget.user)
        .where((c) => c.title.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Courses"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ de recherche
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search courses...",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => search = val),
            ),
            const SizedBox(height: 20),

            // ===== MY COURSES =====
            if (myCourses.isNotEmpty) ...[
              const Text(
                "My Courses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myCourses.length,
                  itemBuilder: (context, index) {
                    final course = myCourses[index];
                    return Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: course.icons.isNotEmpty
                                    ? Image.network(
                                  course.icons,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  height: 100,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.school, size: 50),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                course.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${course.modulesCount} modules",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 30,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CourseLessonsPage(course: course),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    "See Lessons",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 30),

            // ===== RECOMMENDED COURSES =====
            if (recommendedCourses.isNotEmpty) ...[
              const Text(
                "Recommended Courses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedCourses.length,
                  itemBuilder: (context, index) {
                    final course = recommendedCourses[index];
                    return Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: course.icons.isNotEmpty
                                    ? Image.network(
                                  course.icons,
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  height: 100,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.school, size: 30),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                course.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                course.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${course.modulesCount} modules • ${course.price} TND",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 28,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Achat disponible bientôt")));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    "Buy",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 28,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CourseLessonsPage(course: course),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    "See Lessons",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
