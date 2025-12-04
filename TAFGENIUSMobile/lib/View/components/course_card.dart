import 'package:flutter/material.dart';
import '../../Model/course_model.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final double progress; // 0.0 à 1.0
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.course,
    this.progress = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("${course.lessons.length} lessons",
                  style: const TextStyle(color: Colors.grey)),
              Text("${course.price.toStringAsFixed(2)} TND",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              if (progress > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 4),
                      Text("${(progress * 100).round()}% completed",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
