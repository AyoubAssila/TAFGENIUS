import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Model/course_model.dart';
import '../../Model/lesson_model.dart';
import '../../Model/user_model.dart';
import '../backend/firestore/services/user_service.dart';

class CourseDetailViewModel extends ChangeNotifier {
  final CourseModel course;
  final UserModel? user;

  List<LessonModel> lessons = [];
  double progressValue = 0;

  final _db = FirebaseFirestore.instance;
  final UserService _userService = UserService(); // <-- Firestore progress

  CourseDetailViewModel({required this.course, this.user}) {
    loadLessons();
    computeProgress();
  }

  bool get hasAccess => user?.purchasedCourses.contains(course.id) ?? false;

  ///  charge les leçons du cours
  void loadLessons() {
    _db
        .collection("courses")
        .doc(course.id)
        .collection("lessons")
        .orderBy("order")
        .snapshots()
        .listen((snapshot) {
      lessons = snapshot.docs
          .map((doc) => LessonModel.fromMap(doc.data(), doc.id))
          .toList();

      computeProgress();
      notifyListeners();
    });
  }

  ///  calcule le progrès local
  void computeProgress() {
    if (!hasAccess || user == null) {
      progressValue = 0;
      return;
    }

    final prog = user!.progress[course.id];
    progressValue = prog?.percent ?? 0;
    notifyListeners();
  }

  List<String> get completedLessons {
    if (!hasAccess || user == null) return [];
    return user!.progress[course.id]?.completedLessonIds ?? [];
  }

  ///  Marquer une leçon comme accomplie + maj Firestore
  void markLessonCompleted(String lessonId) {
    if (!hasAccess || user == null) return;

    final currentProgress = user!.progress[course.id] ??
        Progress(
            percent: 0, lastLessonId: '', updatedAt: DateTime.now(), completedLessonIds: []);

    final completedSet = Set<String>.from(currentProgress.completedLessonIds);
    completedSet.add(lessonId);

    final newPercent = (completedSet.length / lessons.length).clamp(0.0, 1.0);

    final updatedProgress = Progress(
      percent: newPercent,
      lastLessonId: lessonId,
      updatedAt: DateTime.now(),
      completedLessonIds: completedSet.toList(),
    );

    ///  Mise à jour locale
    user!.progress[course.id] = updatedProgress;
    progressValue = newPercent;

    /// Mise à jour Firestore via UserService
    _userService.updateCourseProgress(user!.id, course.id, updatedProgress);

    notifyListeners();
  }
}
