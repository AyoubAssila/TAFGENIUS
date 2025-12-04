import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/user_model.dart';

class UserService {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  // -------- CRUD --------
  Future<void> createUser(UserModel user) async {
    await usersCollection.doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await usersCollection.doc(userId).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await usersCollection.doc(userId).update(data);
  }

  Future<void> deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
  }

  // -------- Progrès --------
  Future<void> updateCourseProgress(
      String userId, String courseId, Progress progress) async {
    await usersCollection.doc(userId).update({
      "progress.$courseId": progress.toMap(),
    });
    await _updateGlobalProgress(userId);
  }

  Future<Progress?> getCourseProgress(String userId, String courseId) async {
    final doc = await usersCollection.doc(userId).get();
    if (!doc.exists) return null;

    final progressMap = (doc.data() as Map<String, dynamic>)["progress"];
    if (progressMap == null || !progressMap.containsKey(courseId)) return null;

    return Progress.fromMap(progressMap[courseId]);
  }

  // -------- Calculer le progrès global --------
  Future<void> _updateGlobalProgress(String userId) async {
    final doc = await usersCollection.doc(userId).get();
    if (!doc.exists) return;

    final progressMap = (doc.data() as Map<String, dynamic>)["progress"];
    if (progressMap == null || progressMap.isEmpty) return;

    double total = 0;
    progressMap.forEach((key, value) {
      total += (value['percent'] ?? 0);
    });
    final globalProgress = total / progressMap.length;

    await usersCollection.doc(userId).update({"globalProgress": globalProgress});
  }

  // -------- Liste complète des utilisateurs --------
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await usersCollection.orderBy('createdAt').get();
    return snapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .toList();
  }

  // -------- Recherche par rôle --------
  Future<List<UserModel>> getUsersByRole(String role) async {
    final snapshot = await usersCollection.where('role', isEqualTo: role).get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  // -------- Filtrer par nom/email --------
  Future<List<UserModel>> searchUsers(String query) async {
    final snapshot = await usersCollection.get();
    final lowerQuery = query.toLowerCase();

    return snapshot.docs
        .map((doc) => UserModel.fromFirestore(doc))
        .where((user) =>
    user.name.toLowerCase().contains(lowerQuery) ||
        user.email.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
