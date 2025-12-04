import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String id;
  String courseId;
  String title;
  String description;
  int timeLimit;
  bool shuffleQuestions;
  int scoreFinal;
  int totalQuestions;
  DateTime createdAt;
  String createdBy;

  QuizModel({
    this.id = '',
    required this.courseId,
    required this.title,
    required this.description,
    required this.timeLimit,
    required this.shuffleQuestions,
    this.scoreFinal = 0,
    this.totalQuestions = 0,
    DateTime? createdAt,
    required this.createdBy,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'title': title,
      'description': description,
      'timeLimit': timeLimit,
      'shuffleQuestions': shuffleQuestions,
      'scoreFinal': scoreFinal,
      'totalQuestions': totalQuestions,
      'createdAt': createdAt,
      'createdBy': createdBy,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map, String id) {
    return QuizModel(
      id: id,
      courseId: map['courseId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      timeLimit: map['timeLimit'] ?? 0,
      shuffleQuestions: map['shuffleQuestions'] ?? false,
      scoreFinal: map['scoreFinal'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: map['createdBy'] ?? '',
    );
  }
}
