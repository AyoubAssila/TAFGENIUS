import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;

  /// LOGIN avec email/password - CORRIGÉ
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print("🔄 Login pour: ${email.trim()}");

      // 1. Authentification Firebase
      final result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = result.user;
      if (user == null) throw Exception("Échec authentification");

      print("✅ Auth réussie! UID: ${user.uid}");

      // 2. Chercher utilisateur dans Firestore
      DocumentSnapshot userDoc;

      // ESSAYER PAR UID D'ABORD
      userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // CHERCHER PAR EMAIL
        final query = await _firestore.collection('users')
            .where('email', isEqualTo: email.trim())
            .limit(1)
            .get();

        if (query.docs.isEmpty) {
          throw Exception("Utilisateur non trouvé dans Firestore");
        }

        userDoc = query.docs.first;

        // MIGRER: Mettre à jour avec le bon UID
        if (userDoc.id != user.uid) {
          await _firestore.collection('users').doc(user.uid).set(
            userDoc.data() as Map<String, dynamic>,
          );
          await _firestore.collection('users').doc(userDoc.id).delete();
          userDoc = await _firestore.collection('users').doc(user.uid).get();
        }
      }

      // 3. EXTRAIRE LE RÔLE CORRECTEMENT
      final userData = userDoc.data() as Map<String, dynamic>?;
      if (userData == null) throw Exception("Données utilisateur corrompues");

      final rawRole = userData['role'];
      print("Rôle brut: '$rawRole'");

      // CORRECTION DU RÔLE
      String role;
      if (rawRole == null) {
        role = 'student';
      } else if (rawRole is String) {
        // CORRECTION DES ROLES
        final cleaned = rawRole.trim().toLowerCase();

        if (cleaned.contains('webmaster') && cleaned.contains('content')) {
          role = 'content_webmaster';
        } else if (cleaned.contains('webmaster') && cleaned.contains('technical')) {
          role = 'technical_webmaster';
        } else if (cleaned.contains('commercial')) {
          role = 'commercial';
        } else if (cleaned.contains('student')) {
          role = 'student';
        } else {
          // Garder la valeur originale
          role = cleaned.replaceAll(' ', '_').replaceAll('-', '_');
        }
      } else {
        role = rawRole.toString().trim().toLowerCase().replaceAll(' ', '_');
      }

      print("Rôle final: '$role'");

      // 4. VALIDER LE RÔLE
      final allowedRoles = ['student', 'content_webmaster', 'technical_webmaster', 'commercial'];
      if (!allowedRoles.contains(role)) {
        print("❌ Rôle non autorisé: '$role'");
        await _auth.signOut();
        throw Exception("Rôle '$role' non autorisé");
      }

      return {
        'user': user,
        'role': role,
        'userData': userData,
      };

    } on FirebaseAuthException catch (e) {
      print("Erreur auth: ${e.code}");
      if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        throw Exception("Email ou mot de passe incorrect");
      } else if (e.code == 'user-not-found') {
        throw Exception("Aucun compte avec cet email");
      }
      throw Exception("Erreur: ${e.message}");
    } catch (e) {
      print("Erreur login: $e");
      rethrow;
    }
  }

  /// SIGNUP avec email
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String fullName,
    String role = 'etudiant',
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = result.user;
      if (user == null) throw Exception("Échec création");

      await _firestore.collection('users').doc(user.uid).set({
        'name': fullName,
        'email': email.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return {'user': user, 'role': role};
    } catch (e) {
      print("Erreur signup: $e");
      rethrow;
    }
  }

  /// LOGIN avec Google
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception("Annulé");

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) throw Exception("Échec Google auth");

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? "",
          'email': user.email ?? "",
          'role': 'etudiant',
          'createdAt': FieldValue.serverTimestamp(),
        });
        return {'user': user, 'role': 'etudiant'};
      }

      final userData = userDoc.data() as Map<String, dynamic>?;
      final role = userData?['role']?.toString().toLowerCase() ?? 'etudiant';

      return {'user': user, 'role': role};
    } catch (e) {
      print("Erreur Google: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("Erreur logout: $e");
      rethrow;
    }
  }
}