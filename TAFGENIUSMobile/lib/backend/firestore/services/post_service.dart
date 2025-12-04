import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/post_model.dart';
import '../../../Model/comment_model.dart';
import '../../../Model/attachment_model.dart';

class PostService {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts');

  // ----- CRUD Posts -----
  Future<String> addPost(PostModel post) async {
    DocumentReference doc = await postsCollection.add(post.toMap());
    return doc.id;
  }

  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    await postsCollection.doc(postId).update(data);
  }

  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }

  Future<List<PostModel>> getAllPosts() async {
    var snapshot =
    await postsCollection.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<PostModel?> getPostById(String postId) async {
    var doc = await postsCollection.doc(postId).get();
    if (!doc.exists) return null;
    return PostModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ----- CRUD Comments (sous-collection) -----
  Future<void> addComment(String postId, CommentModel comment) async {
    await postsCollection.doc(postId).collection('comments').add(comment.toMap());
  }

  Future<List<CommentModel>> getComments(String postId) async {
    var snapshot = await postsCollection
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs
        .map((doc) => CommentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updateComment(
      String postId, String commentId, Map<String, dynamic> data) async {
    await postsCollection.doc(postId).collection('comments').doc(commentId).update(data);
  }

  Future<void> deleteComment(String postId, String commentId) async {
    await postsCollection.doc(postId).collection('comments').doc(commentId).delete();
  }
}
