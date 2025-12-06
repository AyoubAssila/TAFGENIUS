import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/course_model.dart';
import '../Model/user_model.dart';
import '../backend/firestore/services/course_service.dart';

class CoursesViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CourseService _courseService = CourseService();

  List<CourseModel> allCourses = [];
  List<CourseModel> filteredCourses = [];

  CoursesViewModel() {
    loadCourses();

    searchController.addListener(() {
      filterCourses(searchController.text);
    });
  }

  /// Charge les cours depuis Firestore en TEMPS RÉEL
  void loadCourses() {
    _db.collection("courses").snapshots().listen((snapshot) {
      allCourses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data(), doc.id))
          .toList();

      filteredCourses = List.from(allCourses);
      notifyListeners();
    });
  }

  /// Filtre des cours pour la recherche
  void filterCourses(String query) {
    if (query.isEmpty) {
      filteredCourses = List.from(allCourses);
    } else {
      filteredCourses = allCourses
          .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Cours achetés par l'utilisateur
  List<CourseModel> myCourses(UserModel user) {
    return allCourses
        .where((c) => user.purchasedCourses.contains(c.id))
        .toList();
  }

  /// Recommended Courses (non achetés)
  List<CourseModel> recommendedCourses(UserModel user) {
    return allCourses
        .where((c) => !user.purchasedCourses.contains(c.id))
        .toList();
  }
}
