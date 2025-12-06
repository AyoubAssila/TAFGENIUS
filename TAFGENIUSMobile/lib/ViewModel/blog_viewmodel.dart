
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/post_model.dart';
import '../Model/comment_model.dart';

class BlogViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PostModel> _allPosts = [];

  // CORRECTION ICI : Ajout du getter 'experiences'
  List<PostModel> get experiences => _allPosts
      .where((post) => post.category == PostCategory.Experiences)
      .toList();

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Pour la page publique
  bool get isVisitor => true;

  /// Initialisation
  Future<void> initialize() async {
    _loading = true;
    notifyListeners();

    await _loadAllPosts();

    _loading = false;
    notifyListeners();
  }

  /// Charge tous les posts
  Future<void> _loadAllPosts() async {
    try {
      final snapshot = await _firestore
          .collection('blogPosts')
          .orderBy('createdAt', descending: true)
          .get();

      _allPosts = snapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
          .toList();

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur chargement: $e';
      print('Erreur chargement: $e');
      notifyListeners();
    }
  }

  // ==================== VISITOR ACTIONS ====================

  void showSignupDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign up to $action"),
        content: const Text("You need to sign up or log in to perform this action."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/login');
            },
            child: const Text("Sign Up / Login"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> likePost(BuildContext context, String postId) async {
    // Les visiteurs ne peuvent pas liker
    showSignupDialog(context, "like");
  }

  Future<void> addComment(BuildContext context, String postId, String text) async {
    // Les visiteurs ne peuvent pas commenter
    showSignupDialog(context, "comment");
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Méthode pour vérifier si un post existe
  PostModel? getPostById(String postId) {
    try {
      return _allPosts.firstWhere((post) => post.id == postId);
    } catch (e) {
      return null;
    }
  }

  // Méthode pour rafraîchir les données
  Future<void> refresh() async {
    await _loadAllPosts();
  }
}