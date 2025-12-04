import 'package:cloud_firestore/cloud_firestore.dart';

class Logs {
  final String userId;
  final String courseId;
  final String lessonId;
  final String type;
  final String details;
  final DateTime timestamp;

  Logs({
    required this.userId,
    required this.courseId,
    required this.lessonId,
    required this.type,
    required this.details,
    required this.timestamp,
  });

  factory Logs.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Logs(
      userId: data['userId'] ?? "",
      courseId: data['courseId'] ?? "",
      lessonId: data['lessonId'] ?? "",
      type: data['type'] ?? "",
      details: data['details'] ?? "",
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
