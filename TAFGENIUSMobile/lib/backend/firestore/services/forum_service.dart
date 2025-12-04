import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tafgeniusmobile/Model/forum_thread_model.dart';

class ForumService {
  final CollectionReference forumThreadsCollection =
  FirebaseFirestore.instance.collection('forum_threads');

  // Ajouter un thread
  Future<void> addThread(ForumThread thread) async {
    await forumThreadsCollection.add(thread.toMap());
  }

  // Récupérer tous les threads
  Future<List<ForumThread>> getAllThreads() async {
    final snapshot = await forumThreadsCollection.get();
    return snapshot.docs
        .map((doc) => ForumThread.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Ajouter une réponse à un thread
  Future<void> addReply(String threadId, Reply reply) async {
    final docRef = forumThreadsCollection.doc(threadId);
    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      List replies = data['replies'] ?? [];
      replies.add(reply.toMap());
      await docRef.update({'replies': replies});
    }
  }

  // Mettre à jour un thread
  Future<void> updateThread(ForumThread thread) async {
    await forumThreadsCollection.doc(thread.id).update(thread.toMap());
  }

  // Supprimer un thread
  Future<void> deleteThread(String threadId) async {
    await forumThreadsCollection.doc(threadId).delete();
  }
}
