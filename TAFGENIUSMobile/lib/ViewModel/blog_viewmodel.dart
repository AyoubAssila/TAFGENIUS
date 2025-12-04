import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/post_model.dart';
import '../Model/comment_model.dart';

class BlogViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _selectedCategory = 'all'; // 'all', 'opinions', 'experiences', 'articles'

  // Initialiser
  Future<void> initialize() async {
    _loading = true;
    notifyListeners();

    try {
      await _loadPosts();
    } catch (e) {
      _errorMessage = 'Erreur de chargement: $e';
    }

    _loading = false;
    notifyListeners();
  }

  // Charger les posts depuis Firestore
  Future<void> _loadPosts() async {
    try {
      Query query = _firestore
          .collection('blogPosts')
          .orderBy('createdAt', descending: true);

      // Filtrer par catégorie si nécessaire
      if (_selectedCategory != 'all') {
        query = query.where('category', isEqualTo: _selectedCategory);
      }

      final snapshot = await query.get();

      _posts = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return PostModel.fromMap(data, doc.id);
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Erreur chargement posts: $e');
    }
  }

  // Changer de catégorie
  Future<void> changeCategory(String category) async {
    _selectedCategory = category;
    _loading = true;
    notifyListeners();

    await _loadPosts();

    _loading = false;
    notifyListeners();
  }

  // Liker un post
  Future<void> likePost(String id) async {
    try {
      final index = _posts.indexWhere((p) => p.id == id);
      if (index == -1) return;

      _posts[index].likes++;

      // Mettre à jour dans Firestore
      await _firestore.collection('blogPosts').doc(id).update({
        'likes': _posts[index].likes,
      });

      notifyListeners();
    } catch (e) {
      print('Erreur like: $e');
    }
  }

  // Ajouter un commentaire
  Future<void> addComment(String postId, String text) async {
    try {
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index == -1) return;

      final newComment = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorName: "Visiteur",
        authorRole: "Public",
        content: text,
        createdAt: DateTime.now(),
      );

      // Ajouter localement
      _posts[index].comments.add(newComment);

      // Mettre à jour Firestore dans la sous-collection
      await _firestore
          .collection('blogPosts')
          .doc(postId)
          .collection('comments')
          .doc(newComment.id)
          .set(newComment.toMap());

      notifyListeners();
    } catch (e) {
      print('Erreur commentaire: $e');
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Getters pour les statistiques
  int get totalPosts => _posts.length;
  int get totalLikes => _posts.fold(0, (sum, post) => sum + post.likes);

  // Obtenir les posts par catégorie
  List<PostModel> getOpinions() => _posts.where((p) => p.category == PostCategory.Opinions).toList();
  List<PostModel> getExperiences() => _posts.where((p) => p.category == PostCategory.Experiences).toList();
  List<PostModel> getArticles() => _posts.where((p) => p.category == PostCategory.Articles).toList();
}