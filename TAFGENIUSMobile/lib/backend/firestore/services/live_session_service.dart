import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tafgeniusmobile/Model/live_session_model.dart';
import '../../../Model/live_session_model.dart';

class LiveSessionService {
  final CollectionReference liveSessionsCollection =
  FirebaseFirestore.instance.collection('live_sessions');

  // Ajouter une session live
  Future<void> addLiveSession(LiveSession session) async {
    await liveSessionsCollection.add(session.toMap());
  }

  // Récupérer toutes les sessions
  Future<List<LiveSession>> getAllLiveSessions() async {
    final snapshot = await liveSessionsCollection.get();
    return snapshot.docs
        .map((doc) => LiveSession.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Mettre à jour une session
  Future<void> updateLiveSession(LiveSession session) async {
    await liveSessionsCollection.doc(session.id).update(session.toMap());
  }

  // Supprimer une session
  Future<void> deleteLiveSession(String sessionId) async {
    await liveSessionsCollection.doc(sessionId).delete();
  }
}
