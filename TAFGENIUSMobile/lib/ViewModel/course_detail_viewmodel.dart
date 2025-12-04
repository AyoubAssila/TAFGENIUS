import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Model/course_model.dart';
import '../../Model/lesson_model.dart';
import '../../Model/user_model.dart';

class CourseDetailViewModel extends ChangeNotifier {
  final CourseModel course;
  final UserModel? user;

  List<LessonModel> lessons = [];
  double progressValue = 0;

  final _db = FirebaseFirestore.instance;

  CourseDetailViewModel({required this.course, this.user}) {
    loadLessons();
    computeProgress();
  }

  /// Vérifie si l'utilisateur a acheté ce cours
  bool get hasAccess => user?.purchasedCourses.contains(course.id) ?? false;

  /// Charge les leçons depuis Firestore
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
      computeProgress(); // recalculer le progrès
      notifyListeners();
    });
  }

  /// Calcule le progrès actuel de l'utilisateur pour ce cours
  void computeProgress() {
    if (!hasAccess || user == null) {
      progressValue = 0;
      return;
    }

    final prog = user!.progress[course.id];
    progressValue = prog?.percent ?? 0;
    notifyListeners();
  }

  /// Getter pour récupérer les leçons complétées
  List<String> get completedLessons {
    if (!hasAccess || user == null) return [];
    return user!.progress[course.id]?.completedLessonIds ?? [];
  }

  /// Marque une leçon comme complétée et met à jour le progrès
  void markLessonCompleted(String lessonId) {
    if (!hasAccess || user == null) return;

    final currentProgress = user!.progress[course.id] ??
        Progress(percent: 0, lastLessonId: '', updatedAt: DateTime.now());

    // Récupérer les leçons complétées
    final completedSet = Set<String>.from(currentProgress.completedLessonIds);
    completedSet.add(lessonId);

    final newPercent = (completedSet.length / lessons.length).clamp(0.0, 1.0);

    final updatedProgress = Progress(
      percent: newPercent,
      lastLessonId: lessonId,
      updatedAt: DateTime.now(),
      completedLessonIds: completedSet.toList(),
    );

    // Met à jour localement et dans Firestore
    user!.progress[course.id] = updatedProgress;
    progressValue = newPercent;

    updateProgressInFirestore(course.id, updatedProgress);
    notifyListeners();
  }

  /// Persiste le progrès dans Firestore
  Future<void> updateProgressInFirestore(String courseId, Progress progress) async {
    if (user == null) return;
    await _db.collection('users').doc(user!.id).update({
      'progress.$courseId': progress.toMap(),
    });
  }
}
