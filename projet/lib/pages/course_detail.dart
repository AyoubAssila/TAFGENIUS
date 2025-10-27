import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// --- MODEL ---
class CourseModel {
  final String title;
  final String instructor;
  final String date;
  final List<String> chapters;
  final List<String> videos;
  final List<DateTime> meetDates;
  final double progress; // 0.0 à 1.0
  final bool quizCompleted;
  final bool courseCompleted;

  CourseModel({
    required this.title,
    required this.instructor,
    required this.date,
    required this.chapters,
    required this.videos,
    required this.meetDates,
    this.progress = 0.0,
    this.quizCompleted = false,
    this.courseCompleted = false,
  });
}

/// --- UI PAGE ---
class CourseDetailPage extends StatelessWidget {
  final CourseModel course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 60,
            backgroundColor: Colors.blue[700],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Instructor & Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Instructor", style: TextStyle(color: Colors.grey[600])),
                          Text(course.instructor,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Start Date", style: TextStyle(color: Colors.grey[600])),
                          Text(course.date,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Progress Circle
                  Center(
                    child: CircularPercentIndicator(
                      radius: 65,
                      lineWidth: 8,
                      percent: course.progress,
                      center: Text(
                        "${(course.progress * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      progressColor: Colors.blue[700],
                      backgroundColor: Colors.grey[300]!,
                      animation: true,
                    ),
                  ),
                  const SizedBox(height: 18),

                  /// Chapters
                  const Text("Chapters",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  ...course.chapters.map((chapter) => Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.blue),
                      title: Text(chapter, style: const TextStyle(fontSize: 15)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  )),

                  const SizedBox(height: 14),

                  /// Videos
                  const Text("Videos",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  ...course.videos.map((video) => Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: ListTile(
                      leading: const Icon(Icons.play_circle_fill, color: Colors.red),
                      title: Text(video, style: const TextStyle(fontSize: 15)),
                    ),
                  )),

                  const SizedBox(height: 14),

                  /// Meetings
                  if (course.meetDates.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Meetings",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          children: course.meetDates
                              .map((date) => Chip(
                            label: Text(
                                "${date.day}/${date.month}/${date.year}"),
                            backgroundColor: Colors.blue[200],
                          ))
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),

                  /// Take Quiz Button
                  ElevatedButton(
                    onPressed: course.progress == 1.0
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Quiz started!")),
                      );
                    }
                        : null, // désactivé si progress < 100%
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Take Quiz",
                        style: TextStyle(fontSize: 15)),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
