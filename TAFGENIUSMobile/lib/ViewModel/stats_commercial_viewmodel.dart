import 'package:flutter/material.dart';
import '../Model/stats_commercial_model.dart';

class StatsViewModel extends ChangeNotifier {
  late StatsData stats;

  StatsViewModel() {
    loadStats();
  }

  void loadStats() {
    // === THE SAME STATIC DATA YOU PROVIDED ===
    stats = StatsData(
      totalUsers: 1245,
      ageGroups: {
        '<18': 120,
        '18-24': 540,
        '25-34': 380,
        '35+': 205,
      },
      users80Progress: 420,
      usersWithCertificates: 98,
      topCourses: {
        'Motivation Mastery': 320,
        'Java Essentials': 280,
        'Laravel Bootcamp': 210,
        'Design Thinking': 180,
        'Productivity Hacks': 150,
        'React Complete': 130,
        'Python ML': 120,
        'UI/UX': 110,
        'Data Analysis': 95,
        'Entrepreneurship': 80,
      },
    );
  }
}