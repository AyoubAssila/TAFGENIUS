import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../backend/auth/firebase_auth_service.dart';
import '../../Model/post_model.dart';
import '../../Model/attachment_model.dart';

class BlogContentWebmasterViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _authService = FirebaseAuthService();

  List<PostModel> _allPosts = [];
  List<PostModel> get experiences => _allPosts.where((p) => p.category == PostCategory.Experiences).toList();
  List<PostModel> get articles => _allPosts.where((p) => p.category == PostCategory.Articles).toList();
  List<PostModel> get motivations => _allPosts.where((p) => p.category == PostCategory.Motivation).toList();

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _currentUserId;
  String? _currentUserName;

  bool get isVisitor => _currentUserId == null;

  String _selectedTab = 'experiences';
  String get selectedTab => _selectedTab;

  Future<void> initialize() async {
    _loading = true;
    notifyListeners();

    try {
      final user = _authService.currentUser;
      if (user != null) {
        _currentUserId = user.uid;
        _currentUserName = user.displayName ?? 'Webmaster';
      }

      await _loadAllPosts();
    } catch (e) {
      _errorMessage = 'Erreur: $e';
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> _loadAllPosts() async {
    try {
      final snapshot = await _firestore
          .collection('blogPosts')
          .orderBy('createdAt', descending: true)
          .get();

      _allPosts = snapshot.docs.map((doc) => PostModel.fromMap(doc.data(), doc.id)).toList();
      notifyListeners();
    } catch (e) {
      print('Erreur chargement: $e');
    }
  }

  void showSignupDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign up to $action"),
        content: const Text("You need to sign up or login to perform this action."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
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

  Future<void> addPost(BuildContext context,
      {required String text,
        required PostCategory category,
        List<AttachmentModel> attachments = const []}) async {
    if (isVisitor) {
      showSignupDialog(context, "post");
      return;
    }

    try {
      final newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorName: _currentUserName!,
        authorRole: 'content_webmaster',
        createdAt: DateTime.now(),
        text: text,
        attachments: attachments,
        category: category,
        likes: 0,
      );

      await _firestore.collection('blogPosts').doc(newPost.id).set({
        ...newPost.toMap(),
        'userId': _currentUserId,
      });

      _allPosts.insert(0, newPost);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur création: $e';
      notifyListeners();
    }
  }

  Future<void> moderateExperience(String postId, bool approve) async {
    try {
      await _firestore.collection('blogPosts').doc(postId).update({
        'status': approve ? 'approved' : 'rejected',
      });

      await _loadAllPosts();
    } catch (e) {
      _errorMessage = 'Erreur modération: $e';
      notifyListeners();
    }
  }

  Future<void> deletePost(BuildContext context, String postId) async {
    if (isVisitor) {
      showSignupDialog(context, "delete");
      return;
    }

    try {
      await _firestore.collection('blogPosts').doc(postId).delete();
      _allPosts.removeWhere((p) => p.id == postId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erreur suppression: $e';
      notifyListeners();
    }
  }

  void changeTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
