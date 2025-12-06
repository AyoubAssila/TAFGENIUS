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
  List<PostModel> get posts => _posts;

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _currentUserId;
  String? _currentUserName;

  bool get isVisitor => _currentUserId == null;

  //---------------------------------------------------------
  //   INITIALISATION
  //---------------------------------------------------------
  Future<void> initialize() async {
    _loading = true;
    notifyListeners();

    final user = _authService.currentUser;

    if (user != null) {
      _currentUserId = user.uid;
      _currentUserName = user.displayName ?? "Student";
    }

    await _loadPublicPosts();
    await _loadUserPosts(); // ← Charge automatiquement les posts de l’étudiant

    _loading = false;
    notifyListeners();
  }

  //---------------------------------------------------------
  //   CHARGER LES POSTS PUBLICS
  //---------------------------------------------------------
  Future<void> _loadPublicPosts() async {
    try {
      final snapshot = await _firestore
          .collection("blogPosts")
          .where("category", whereIn: ["Experiences", "Articles", "Motivation"])
          .where("status", isEqualTo: "published")
          .get();

      final publicPosts = snapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
          .toList();

      _posts.addAll(publicPosts);
    } catch (e) {
      _errorMessage = "Error loading public posts: $e";
    }
  }

  //---------------------------------------------------------
  //   CHARGER LES POSTS PERSONNELS (MÊME APRÈS DECONNEXION)
  //---------------------------------------------------------
  Future<void> _loadUserPosts() async {
    if (_currentUserId == null) return;

    try {
      final snapshot = await _firestore
          .collection("blogPosts")
          .where("userId", isEqualTo: _currentUserId)
          .get();

      final userPosts = snapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
          .toList();

      _posts.addAll(userPosts);

      // Tri chronologique
      _posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      notifyListeners();
    } catch (e) {
      _errorMessage = "Error loading user posts: $e";
    }
  }

  //---------------------------------------------------------
  //   AJOUTER UN POST
  //---------------------------------------------------------
  Future<void> addPost(
      BuildContext context, {
        required String text,
        List<AttachmentModel> attachments = const [],
      }) async {
    if (isVisitor) {
      showSignupDialog(context, "post");
      return;
    }

    try {
      final postId = DateTime.now().millisecondsSinceEpoch.toString();

      final newPost = PostModel(
        id: postId,
        authorName: _currentUserName!,
        authorRole: "student",
        createdAt: DateTime.now(),
        text: text,
        attachments: attachments,
        category: PostCategory.Motivation,
        likes: 0,
        comments: [],
      );

      await _firestore.collection("blogPosts").doc(postId).set({
        ...newPost.toMap(),
        "userId": _currentUserId,
        "status": "published",
      });

      _posts.insert(0, newPost);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error adding post: $e";
      notifyListeners();
    }
  }

  //---------------------------------------------------------
  //   LIKE POST
  //---------------------------------------------------------
  Future<void> likePost(BuildContext context, String postId) async {
    if (isVisitor) {
      showSignupDialog(context, "like");
      return;
    }

    try {
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index == -1) return;

      _posts[index].likes++;

      await _firestore.collection("blogPosts").doc(postId).update({
        "likes": _posts[index].likes,
      });

      notifyListeners();
    } catch (e) {
      print("Error liking post: $e");
    }
  }

  //---------------------------------------------------------
  //   ADD COMMENT
  //---------------------------------------------------------
  Future<void> addComment(
      BuildContext context, String postId, String text) async {
    if (isVisitor) {
      showSignupDialog(context, "comment");
      return;
    }

    try {
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index == -1) return;

      final newComment = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorName: _currentUserName!,
        authorRole: "student",
        content: text,
        createdAt: DateTime.now(),
      );

      _posts[index].comments.add(newComment);

      await _firestore
          .collection("blogPosts")
          .doc(postId)
          .collection("comments")
          .doc(newComment.id)
          .set(newComment.toMap());

      notifyListeners();
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  //---------------------------------------------------------
  //   DELETE POST
  //---------------------------------------------------------
  Future<void> deletePost(String postId) async {
    try {
      final post = _posts.firstWhere((p) => p.id == postId);

      if (post.authorName != _currentUserName) {
        _errorMessage = "You can only delete your own posts";
        notifyListeners();
        return;
      }

      await _firestore.collection("blogPosts").doc(postId).delete();
      _posts.removeWhere((p) => p.id == postId);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error deleting post: $e";
      notifyListeners();
    }
  }
  void showSignupDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign up to $action"),
        content: const Text(
            "You need to sign up or login to perform this action."
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO : redirection vers login/signup
              // Navigator.pushNamed(context, "/login");
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

}
