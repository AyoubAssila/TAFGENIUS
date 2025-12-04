import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/blog_model.dart';

class BlogService {
  final CollectionReference blogCollection =
  FirebaseFirestore.instance.collection('blog');

  // ----- CRUD Blog -----
  Future<String> addBlog(BlogModel blog) async {
    DocumentReference doc = await blogCollection.add(blog.toMap());
    return doc.id;
  }

  Future<void> updateBlog(String blogId, Map<String, dynamic> data) async {
    await blogCollection.doc(blogId).update(data);
  }

  Future<void> deleteBlog(String blogId) async {
    await blogCollection.doc(blogId).delete();
  }

  Future<List<BlogModel>> getAllBlogs() async {
    var snapshot =
    await blogCollection.orderBy('createdAt', descending: true).get();
    return snapshot.docs
        .map((doc) => BlogModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<BlogModel?> getBlogById(String blogId) async {
    var doc = await blogCollection.doc(blogId).get();
    if (!doc.exists) return null;
    return BlogModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // Filtrer par status
  Future<List<BlogModel>> getBlogsByStatus(String status) async {
    var snapshot = await blogCollection.where('status', isEqualTo: status).get();
    return snapshot.docs
        .map((doc) => BlogModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
