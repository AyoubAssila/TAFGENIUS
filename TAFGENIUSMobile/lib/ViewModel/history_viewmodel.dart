import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/course_model.dart';
import '../Model/quizz_model.dart';
import '../Model/certificate_model.dart';
import '../Model/payment_model.dart';
import '../Model/user_model.dart';

class HistoryViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Données
  List<CourseModel> courses = [];
  List<QuizModel> quizzes = [];
  List<CertificateModel> certificates = [];
  List<PaymentModel> payments = [];

  // Charger toutes les données pour un utilisateur
  Future<void> loadAllHistory(String userId) async {
    await Future.wait([
      loadCourses(userId),
      loadQuizzes(userId),
      loadCertificates(userId),
      loadPayments(userId),
    ]);
  }

  // ---------- Méthodes de chargement ----------

  Future<void> loadCourses(String userId) async {
    try {
      final userDoc = await _db.collection('users').doc(userId).get();
      if (!userDoc.exists) return;

      final userData = userDoc.data();
      if (userData == null) return;

      Map<String, dynamic> progressMap = userData['progress'] ?? {};

      final snapshot = await _db.collection('courses').get();
      courses = snapshot.docs.map((doc) {
        final course = CourseModel.fromMap(doc.data(), doc.id);
        if (progressMap.containsKey(course.id)) {
          course.modulesCount = (progressMap[course.id]['percent'] ?? 0).toInt();
        }
        return course;
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading courses: $e");
    }
  }

  Future<void> loadQuizzes(String userId) async {
    try {
      final userDoc = await _db.collection('users').doc(userId).get();
      if (!userDoc.exists) return;

      final userData = userDoc.data();
      if (userData == null) return;

      Map<String, dynamic> quizzesScore = userData['quizzesScore'] ?? {};

      final snapshot = await _db.collection('quizzes').get();
      quizzes = snapshot.docs.map((doc) {
        final quiz = QuizModel.fromMap(doc.data(), doc.id);
        quiz.scoreFinal = quizzesScore[quiz.id]?.toInt() ?? 0;
        return quiz;
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading quizzes: $e");
    }
  }

  Future<void> loadCertificates(String userId) async {
    try {
      final snapshot = await _db
          .collection('certificates')
          .where('userId', isEqualTo: userId)
          .get();

      certificates = snapshot.docs
          .map((doc) => CertificateModel.fromMap(doc.data(), doc.id))
          .toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading certificates: $e");
    }
  }

  Future<void> loadPayments(String userId) async {
    try {
      final snapshot = await _db
          .collection('payments')
          .where('userId', isEqualTo: userId)
          .get();

      payments = snapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.data(), doc.id))
          .toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading payments: $e");
    }
  }
}
