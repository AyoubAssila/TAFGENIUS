import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardViewModel extends ChangeNotifier {
  int coursesCount = 0;
  int quizzesCount = 0;
  int certificatesCount = 0;

  Map<String, int> weeklyActivity = {
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
    "Sun": 0,
  };

  bool isLoading = true;

  Future<void> loadDashboard(String userId) async {
    isLoading = true;
    notifyListeners();

    final db = FirebaseFirestore.instance;

    try {
      // 📌 1. Cours suivis par l'étudiant
      final coursesSnap = await db
          .collection('courses')
          .where('students', arrayContains: userId)
          .get();
      coursesCount = coursesSnap.size;

      // 📌 2. Quizzes effectués par l'étudiant
      final quizzesSnap = await db
          .collection('quizzesTaken')
          .where('userId', isEqualTo: userId)
          .get();
      quizzesCount = quizzesSnap.size;

      // 📌 3. Certificats de l'étudiant
      final certSnap = await db
          .collection('certificates')
          .where('userId', isEqualTo: userId)
          .get();
      certificatesCount = certSnap.size;

      // 📌 4. Activité de la semaine (on compte les quizzes réalisés)
      for (var doc in quizzesSnap.docs) {
        final date = (doc['date'] as Timestamp).toDate();
        final weekday = _weekdayName(date.weekday);

        weeklyActivity[weekday] = (weeklyActivity[weekday] ?? 0) + 1;
      }
    } catch (e) {
      print("DASHBOARD ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  String _weekdayName(int day) {
    switch (day) {
      case 1: return "Mon";
      case 2: return "Tue";
      case 3: return "Wed";
      case 4: return "Thu";
      case 5: return "Fri";
      case 6: return "Sat";
      case 7: return "Sun";
      default: return "Mon";
    }
  }
}
