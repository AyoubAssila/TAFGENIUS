// src/backend/auth/firebaseAuthService.js
import { auth, firestore } from "../../firebaseConfig.js";
import { 
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  signOut,
  GoogleAuthProvider,
  signInWithPopup
} from "firebase/auth";
import { doc, getDoc, setDoc, serverTimestamp, query, collection, where, getDocs } from "firebase/firestore";
import { ActivityService } from "@backend/firestore/services/activityService.js";

export const FirebaseAuthService = {
  
  currentUser: () => auth.currentUser,

  // LOGIN avec email/password
  login: async ({ email, password }) => {
    try {
      console.log("🔄 Login pour:", email.trim());
      const result = await signInWithEmailAndPassword(auth, email.trim(), password);
      const user = result.user;
      if (!user) throw new Error("Échec authentification");

      console.log("✅ Auth réussie! UID:", user.uid);

      // Chercher utilisateur dans Firestore
      let userDocRef = doc(firestore, "users", user.uid);
      let userDocSnap = await getDoc(userDocRef);

      if (!userDocSnap.exists()) {
        // Chercher par email
        const q = query(collection(firestore, "users"), where("email", "==", email.trim()));
        const querySnapshot = await getDocs(q);
        if (querySnapshot.empty) throw new Error("Utilisateur non trouvé dans Firestore");

        userDocSnap = querySnapshot.docs[0];
        const userData = userDocSnap.data();

        // Mettre à jour Firestore avec UID correct
        await setDoc(doc(firestore, "users", user.uid), userData);
        await setDoc(doc(firestore, "users", userDocSnap.id), {});
        userDocSnap = await getDoc(doc(firestore, "users", user.uid));
      }

      const userData = userDocSnap.data();
      if (!userData) throw new Error("Données utilisateur corrompues");

      // Corriger rôle
      let rawRole = userData.role;
      let role = "student";

      if (rawRole) {
        const cleaned = rawRole.toString().trim().toLowerCase();
        if (cleaned.includes("webmaster") && cleaned.includes("content")) role = "content_webmaster";
        else if (cleaned.includes("webmaster") && cleaned.includes("technical")) role = "technical_webmaster";
        else if (cleaned.includes("commercial")) role = "commercial";
        else if (cleaned.includes("student")) role = "student";
        else role = cleaned.replace(/\s|-/g, "_");
      }

      const allowedRoles = ["student", "content_webmaster", "technical_webmaster", "commercial"];
      if (!allowedRoles.includes(role)) {
        await signOut(auth);
        throw new Error(`Rôle '${role}' non autorisé`);
      }

      await ActivityService.logAuthLogin({ userId: user.uid, email: user.email || userData.email || "" });
      return { user, role, userData };

    } catch (e) {
      console.error("Erreur login:", e);
      throw e;
    }
  },

  // SIGNUP avec email/password
  signup: async ({ email, password, fullName, role = "student" }) => {
    try {
      const result = await createUserWithEmailAndPassword(auth, email.trim(), password);
      const user = result.user;
      if (!user) throw new Error("Échec création utilisateur");

      await setDoc(doc(firestore, "users", user.uid), {
        name: fullName,
        email: email.trim(),
        role,
        createdAt: serverTimestamp(),
      });

      await ActivityService.logUserRegistered({ userId: user.uid, email: email.trim(), role });
      return { user, role };
    } catch (e) {
      console.error("Erreur signup:", e);
      throw e;
    }
  },

  // LOGIN avec Google
  signInWithGoogle: async () => {
    try {
      const provider = new GoogleAuthProvider();
      const result = await signInWithPopup(auth, provider);
      const user = result.user;
      if (!user) throw new Error("Échec Google auth");

      const userDocRef = doc(firestore, "users", user.uid);
      const userDocSnap = await getDoc(userDocRef);

      if (!userDocSnap.exists()) {
        await setDoc(userDocRef, {
          name: user.displayName || "",
          email: user.email || "",
          role: "student",
          createdAt: serverTimestamp(),
        });
        return { user, role: "student" };
      }

      const userData = userDocSnap.data();
      const role = userData?.role?.toString().toLowerCase() || "student";
      return { user, role };
    } catch (e) {
      console.error("Erreur Google:", e);
      throw e;
    }
  },

  // LOGOUT
  logout: async () => {
    try {
      await signOut(auth);
    } catch (e) {
      console.error("Erreur logout:", e);
      throw e;
    }
  },
};
