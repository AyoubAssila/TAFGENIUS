import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/user_model.dart';

class DashboardVM extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> users = [];

  DashboardVM() {
    fetchUsers();
  }

  // Récupère les utilisateurs depuis Firebase
  Future<void> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      users = snapshot.docs.map((d) => UserModel.fromFirestore(d)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    }
  }

  int get totalUsers => users.length;

  int get activeStudentsCount => users.where((u) => u.role == 'student').length;
  int get contentWebmastersCount => users.where((u) => u.role == 'content_webmaster').length;
  int get technicalWebmastersCount => users.where((u) => u.role == 'technical_webmaster').length;
  int get commercialCount => users.where((u) => u.role == 'commercial').length;
}
