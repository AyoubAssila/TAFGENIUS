import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../backend/auth/firebase_auth_service.dart';
import '../../Model/post_model.dart';
import '../../Model/comment_model.dart';
import '../../Model/attachment_model.dart';

class BlogEtudiantViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _authService = FirebaseAuthService();

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts.where((p) =>
  p.category != PostCategory.Articles && p.category != PostCategory.Experiences
  ).toList();

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _currentUserId;
  String? _currentUserName;

  // Initialiser
  Future<void> initialize() async {
    _loading = true;
    notifyListeners();

    try {
      final user = _authService.currentUser;
      if (user != null) {
        _currentUserId = user.uid;
        _currentUserName = user.displayName ?? 'Étudiant';
      }

      await _loadPosts();
    } catch (e) {
      _errorMessage = 'Erreur de chargement: $e';
    }

    _loading = false;
    notifyListeners();
  }

  // Charger les posts
  Future<void> _loadPosts() async {
    try {
      final snapshot = await _firestore
          .collection('blogPosts')
          .where('category', whereIn: ['Opinions', 'Experiences'])
          .orderBy('createdAt', descending: true)
          .get();

      _posts = snapshot.docs.map((doc) {
        return PostModel.fromMap(doc.data(), doc.id);
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Erreur chargement posts: $e');
    }
  }

  // Ajouter un post (seulement Opinions)
  Future<void> addPost({
    required String text,
    List<AttachmentModel> attachments = const [],
  }) async {
    if (_currentUserId == null || _currentUserName == null) {
      _errorMessage = 'Non connecté';
      notifyListeners();
      return;
    }

    try {
      final newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorName: _currentUserName!,
        authorRole: 'student',
        createdAt: DateTime.now(),
        text: text,
        attachments: attachments,
        category: PostCategory.Opinions, // Étudiants ne peuvent que opinions
        likes: 0,
      );

      // Sauvegarder dans Firestore
      await _firestore.collection('blogPosts').doc(newPost.id).set({
        ...newPost.toMap(),
        'userId': _currentUserId,
      });

      // Ajouter localement
      _posts.insert(0, newPost);
      notifyListeners();

    } catch (e) {
      _errorMessage = 'Erreur: $e';
      notifyListeners();
    }
  }

  // Ajouter un commentaire
  Future<void> addComment(String postId, String text) async {
    if (_currentUserName == null) return;

    try {
      final newComment = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorName: _currentUserName!,
        authorRole: 'student',
        content: text,
        createdAt: DateTime.now(),
      );

      // Ajouter à la sous-collection comments
      await _firestore
          .collection('blogPosts')
          .doc(postId)
          .collection('comments')
          .doc(newComment.id)
          .set(newComment.toMap());

      // Recharger les posts pour avoir les commentaires
      await _loadPosts();

    } catch (e) {
      print('Erreur commentaire: $e');
    }
  }

  // Liker un post
  Future<void> likePost(String postId) async {
    try {
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index == -1) return;

      _posts[index].likes++;

      await _firestore.collection('blogPosts').doc(postId).update({
        'likes': _posts[index].likes,
      });

      notifyListeners();
    } catch (e) {
      print('Erreur like: $e');
    }
  }

  // Supprimer un post (seulement si auteur)
  Future<void> deletePost(String postId) async {
    try {
      final post = _posts.firstWhere((p) => p.id == postId);

      // Vérifier que c'est l'auteur
      if (post.authorName != _currentUserName) {
        _errorMessage = 'Vous ne pouvez supprimer que vos posts';
        notifyListeners();
        return;
      }

      await _firestore.collection('blogPosts').doc(postId).delete();
      _posts.removeWhere((p) => p.id == postId);

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur suppression: $e';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}