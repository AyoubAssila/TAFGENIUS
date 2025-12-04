import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/user_model.dart';

class UsersVM extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserModel> users = [];
  String search = "";

  UsersVM() {
    fetchUsers();
  }

  // -------- Récupérer les utilisateurs depuis Firestore --------
  Future<void> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      users = snapshot.docs.map((d) => UserModel.fromFirestore(d)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    }
  }

  // -------- Filtrer les utilisateurs pour la recherche --------
  List<UserModel> get filteredUsers {
    return users.where((u) =>
    u.name.toLowerCase().contains(search.toLowerCase()) ||
        u.email.toLowerCase().contains(search.toLowerCase()) ||
        u.role.toLowerCase().contains(search.toLowerCase())
    ).toList();
  }

  void updateSearch(String value) {
    search = value;
    notifyListeners();
  }

  // -------- Supprimer un utilisateur --------
  Future<void> deleteUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).delete();
      users.remove(user);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting user: $e');
    }
  }

  // -------- Ajouter un utilisateur --------
  Future<void> addUser(UserModel user) async {
    try {
      final docRef = await _firestore.collection('users').add(user.toMap());
      user.id = docRef.id;
      users.add(user);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding user: $e');
    }
  }
}
