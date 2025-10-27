import 'package:flutter/material.dart';
import 'course_detail.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _myCourses = [
    {"title": "UI/UX Design", "lessons": "12 lessons", "progress": 0.6},
    {"title": "Programming with Python", "lessons": "10 lessons", "progress": 0.3},
    {"title": "Digital Marketing", "lessons": "8 lessons", "progress": 0.9},
  ];

  final List<Map<String, String>> _recommendedCourses = [
    {"title": "Flutter Development", "lessons": "15 lessons", "price": "60 TND"},
    {"title": "Data Science Basics", "lessons": "10 lessons", "price": "70 TND"},
    {"title": "Graphic Design", "lessons": "8 lessons", "price": "50 TND"},
  ];

  List<Map<String, dynamic>> _filteredMyCourses = [];
  List<Map<String, String>> _filteredRecommended = [];

  @override
  void initState() {
    super.initState();
    _filteredMyCourses = List.from(_myCourses);
    _filteredRecommended = List.from(_recommendedCourses);
  }

  void _filterCourses(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMyCourses = List.from(_myCourses);
        _filteredRecommended = List.from(_recommendedCourses);
      } else {
        _filteredMyCourses = _myCourses
            .where((c) =>
            (c['title'] as String).toLowerCase().contains(query.toLowerCase()))
            .toList();
        _filteredRecommended = _recommendedCourses
            .where((c) =>
            (c['title'] as String).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre de recherche
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search a course...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
            ),
            onChanged: _filterCourses,
          ),
          const SizedBox(height: 16),

          // My Courses
          const Text("My Courses",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (_filteredMyCourses.isEmpty)
            const Center(
                child: Text("No courses found", style: TextStyle(color: Colors.grey))),
          ..._filteredMyCourses.map(
                (course) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailPage(
                      course: CourseModel(
                        title: course['title'],
                        instructor: "John Doe",
                        date: "October 10, 2025",
                        chapters: ["Introduction", "Lesson 1", "Lesson 2"],
                        videos: ["Video 1", "Video 2"],
                        meetDates: [DateTime(2025, 10, 25)],
                        progress: course['progress'],
                      ),
                    ),
                  ),
                );
              },
              child: MyCourseCard(
                  title: course['title'],
                  lessons: course['lessons'],
                  progress: course['progress']),
            ),
          ),

          const SizedBox(height: 24),

          // Recommended Courses
          const Text("Recommended Courses",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (_filteredRecommended.isEmpty)
            const Center(
                child:
                Text("No courses found", style: TextStyle(color: Colors.grey))),
          ..._filteredRecommended.map(
                (course) => RecommendedCourseCard(
                  title: course['title']!,   // <-- le '!' force à dire que ce n'est pas null
                  lessons: course['lessons']!,
                  price: course['price']!,
                ),

          ),
        ],
      ),
    );
  }
}

// Carte My Courses avec barre de progression
class MyCourseCard extends StatelessWidget {
  final String title;
  final String lessons;
  final double progress;

  const MyCourseCard(
      {super.key, required this.title, required this.lessons, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.blue, size: 35),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lessons, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Carte Recommended Courses avec prix
class RecommendedCourseCard extends StatelessWidget {
  final String title;
  final String lessons;
  final String price;

  const RecommendedCourseCard(
      {super.key, required this.title, required this.lessons, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.orange, size: 35),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(lessons, style: const TextStyle(color: Colors.grey)),
        trailing: Text(price,
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
