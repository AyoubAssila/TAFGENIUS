// scripts/migrateUsers.js
import { auth, firestore } from "../src/firebaseConfig.js";
import { getDocs, collection, doc, setDoc, deleteDoc, serverTimestamp } from "firebase/firestore";
import { fetchSignInMethodsForEmail, createUserWithEmailAndPassword } from "firebase/auth";

async function migrateUsersToFirebaseAuth() {
  let createdCount = 0;
  let skippedCount = 0;
  let missingCount = 0;

  try {
    const usersSnapshot = await getDocs(collection(firestore, "users"));
    console.log(`📊 ${usersSnapshot.size} utilisateurs trouvés`);

    for (const userDoc of usersSnapshot.docs) {
      const data = userDoc.data();
      const email = data.email?.trim();
      const password = data.password; // ⚠️ Node.js uniquement, jamais côté front
      const _name = data.name || "Utilisateur";
      const role = data.role || "etudiant";

      if (!email || !password) {
        missingCount++;
        console.log(`❌ Email ou mot de passe manquant pour doc ${userDoc.id}`);
        continue;
      }

      console.log(`\n--- Migration: ${email} ---`);
      console.log(`   Rôle: ${role}`);

      try {
        const methods = await fetchSignInMethodsForEmail(auth, email);

        if (methods.length > 0) {
          skippedCount++;
          console.log(`⚠️ Email déjà utilisé: ${email}, skipping.`);
          continue; // passe au prochain utilisateur
        } else {
          console.log("   🆕 Création dans Firebase Auth...");
          try {
            const userCredential = await createUserWithEmailAndPassword(auth, email, password);
            const uid = userCredential.user.uid;

            // Mise à jour Firestore
            await setDoc(doc(firestore, "users", uid), {
              ...data,
              password: null,
              authCreated: true,
              createdAt: serverTimestamp(),
            });

            if (userDoc.id !== uid) {
              await deleteDoc(doc(firestore, "users", userDoc.id));
            }

            createdCount++;
            console.log(`   ✅ Créé! UID: ${uid}`);
          } catch (e) {
            if (e.code === "auth/email-already-in-use") {
              skippedCount++;
              console.log(`⚠️ Email déjà utilisé (catch): ${email}, skipping.`);
              continue;
            } else {
              throw e;
            }
          }
        }
      } catch (e) {
        console.log(`   ❌ Erreur migration: ${e}`);
      }
    }

    // Résumé final
    console.log("\n📊 Résumé de la migration :");
    console.log(`✅ Créés: ${createdCount}`);
    console.log(`⚠️ Ignorés (existaient déjà): ${skippedCount}`);
    console.log(`❌ Manquants (email/mot de passe): ${missingCount}`);

    console.log("\n✅ Migration terminée!");
  } catch (e) {
    console.error("❌ Erreur migration:", e);
  }
}

// Lancer la migration
migrateUsersToFirebaseAuth();
