import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// REMPLACEZ avec vos valeurs depuis firebase_options.dart
const firebaseConfig = {
  "apiKey": "AIzaSyC_YP-u8_0dUfSkavGS3cvNTR002Kqvsoc",
  "authDomain": "tafgenius.firebaseapp.com",
  "projectId": "tafgenius",
  "storageBucket": "tafgenius.firebasestorage.app",
  "messagingSenderId": "262265089602",
  "appId": "1:262265089602:web:5d406465e41663e9e7c7db"
};

Future<void> main() async {
  print('🚀 Migration Firebase Auth...');

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig['apiKey']!,
      appId: firebaseConfig['appId']!,
      messagingSenderId: firebaseConfig['messagingSenderId']!,
      projectId: firebaseConfig['projectId']!,
      authDomain: firebaseConfig['authDomain'],
      storageBucket: firebaseConfig['storageBucket'],
    ),
  );

  await migrateUsersToFirebaseAuth();
}

Future<void> migrateUsersToFirebaseAuth() async {
  try {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;

    print('🔄 Récupération utilisateurs Firestore...');
    final users = await firestore.collection('users').get();

    print('📊 ${users.docs.length} utilisateurs trouvés');

    for (var doc in users.docs) {
      final data = doc.data();
      final email = data['email']?.toString().trim();
      final password = data['password']?.toString();
      final name = data['name']?.toString() ?? 'Utilisateur';
      final role = data['role']?.toString() ?? 'etudiant';

      if (email == null || email.isEmpty) {
        print('❌ Email manquant pour doc: ${doc.id}');
        continue;
      }

      if (password == null || password.isEmpty) {
        print('❌ Mot de passe manquant pour: $email');
        continue;
      }

      print('\n--- Migration: $email ---');
      print('   Rôle: $role');

      try {
        // Vérifier si existe dans Firebase Auth
        List<String> methods;
        try {
          methods = await auth.fetchSignInMethodsForEmail(email);
        } catch (e) {
          print('   ⚠️ Erreur vérification: $e');
          methods = [];
        }

        if (methods.isNotEmpty) {
          print('   ✅ Existe déjà dans Firebase Auth');

          // Récupérer l'UID
          try {
            // Se connecter pour obtenir l'UID
            final userCredential = await auth.signInWithEmailAndPassword(
              email: email,
              password: password,
            );

            final uid = userCredential.user!.uid;
            print('   🔑 UID: $uid');

            // Déconnecter
            await auth.signOut();

            // Mettre à jour Firestore avec UID comme ID
            if (doc.id != uid) {
              print('   🔄 Mise à jour Firestore avec UID comme ID...');

              // Copier les données avec nouveau ID
              await firestore.collection('users').doc(uid).set({
                ...data,
                'password': null, // Supprimer le mot de passe
                'authMigrated': true,
                'migratedAt': FieldValue.serverTimestamp(),
              });

              // Supprimer l'ancien document
              await firestore.collection('users').doc(doc.id).delete();
              print('   ✅ Migration Firestore terminée');
            }

          } catch (e) {
            print('   ❌ Erreur connexion: $e');
          }

        } else {
          // Créer dans Firebase Auth
          print('   🆕 Création dans Firebase Auth...');
          final userCredential = await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          final uid = userCredential.user!.uid;
          print('   ✅ Créé! UID: $uid');

          // Mettre à jour Firestore
          await firestore.collection('users').doc(uid).set({
            ...data,
            'password': null, // Supprimer le mot de passe
            'authCreated': true,
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          if (doc.id != uid) {
            await firestore.collection('users').doc(doc.id).delete();
          }
        }

      } catch (e) {
        print('   ❌ Erreur migration: $e');
      }
    }

    print('\n✅ Migration terminée!');
    print('Les utilisateurs peuvent maintenant se connecter avec Firebase Auth.');

  } catch (e) {
    print('❌ Erreur migration: $e');
  }
}