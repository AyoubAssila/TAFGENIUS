import 'package:flutter/material.dart';
import '../Model/lesson_model.dart';
import '../Model/course_model.dart';
import '../backend/firestore/services/lesson_service.dart';

class CourseLessonsViewModel extends ChangeNotifier {
  final CourseModel course;
  final LessonService _lessonService = LessonService();

  List<LessonModel> lessons = [];
  bool isLoading = true;

  CourseLessonsViewModel({required this.course}) {
    loadLessons();
  }

  void loadLessons() {
    _lessonService.getLessonsByCourse(course.id).listen((data) {
      lessons = data;
      isLoading = false;
      notifyListeners();
    });
  }

  bool canAccessLesson(LessonModel lesson) => lesson.isFree;
}
