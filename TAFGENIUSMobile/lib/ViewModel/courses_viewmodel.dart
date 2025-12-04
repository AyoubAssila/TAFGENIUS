import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/course_model.dart';
import '../Model/user_model.dart';

class CoursesViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final _db = FirebaseFirestore.instance;

  List<CourseModel> allCourses = [];
  List<CourseModel> filteredCourses = [];

  CoursesViewModel() {
    loadCourses();

    searchController.addListener(() {
      filterCourses(searchController.text);
    });
  }

  void loadCourses() {
    _db.collection("courses").snapshots().listen((snapshot) {
      allCourses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data(), doc.id))
          .toList();
      filteredCourses = List.from(allCourses);
      notifyListeners();
    });
  }

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

  List<CourseModel> myCourses(UserModel user) {
    return allCourses
        .where((c) => user.purchasedCourses.contains(c.id))
        .toList();
  }

  List<CourseModel> recommendedCourses(UserModel user) {
    return allCourses
        .where((c) => !user.purchasedCourses.contains(c.id))
        .toList();
  }
}
