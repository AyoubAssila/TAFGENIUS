import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/course_model.dart';

class HomeViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String searchQuery = "";
  List<CourseModel> courses = [];
  List<CourseModel> filteredCourses = [];
  bool isSearching = false;
  bool showSearch = false;
  final TextEditingController searchController = TextEditingController();

  HomeViewModel() {
    loadCourses();
  }

  // ---------- Firestore ----------
  Future<void> loadCourses() async {
    try {
      final snapshot = await _db.collection('courses').get();
      courses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data(), doc.id))
          .toList();
      filteredCourses = List.from(courses);
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading courses: $e");
    }
  }

  // ---------- Search ----------
  void handleSearchToggle() {
    showSearch = !showSearch;
    if (!showSearch) {
      searchQuery = "";
      filteredCourses = List.from(courses);
      isSearching = false;
      searchController.clear();
    }
    notifyListeners();
  }

  void handleSearchChange(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredCourses = List.from(courses);
      isSearching = false;
    } else {
      filteredCourses = courses
          .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      isSearching = true;
    }
    notifyListeners();
  }

  void handleClearSearch() {
    searchQuery = "";
    filteredCourses = List.from(courses);
    isSearching = false;
    searchController.clear();
    notifyListeners();
  }

  List<CourseModel> getDisplayedCourses() {
    return filteredCourses;
  }
}
