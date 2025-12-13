import {
  collection,
  doc,
  getDoc,
  getDocs,
  setDoc,
  updateDoc,
  deleteDoc,
  query,
  where,
  orderBy,
} from "firebase/firestore";

import { db } from "../../../firebaseConfig.js";
import { UserModel } from "../../../model/UserModel.js";
import { Progress } from "../../../model/UserModel.js";

export const UserService = {
  // -------- CRUD --------

  async createUser(user) {
    await setDoc(doc(db, "users", user.id), user.toMap());
  },

  async getUser(userId) {
    const snapshot = await getDoc(doc(db, "users", userId));
    if (!snapshot.exists()) return null;
    return UserModel.fromFirestore(snapshot);
  },

  async updateUser(userId, data) {
    await updateDoc(doc(db, "users", userId), data);
  },

  async deleteUser(userId) {
    await deleteDoc(doc(db, "users", userId));
  },

  // -------- Progrès --------

  async updateCourseProgress(userId, courseId, progress) {
    // progress est une instance de Progress
    await updateDoc(doc(db, "users", userId), {
      [`progress.${courseId}`]: progress.toMap(),
    });

    await UserService._updateGlobalProgress(userId);
  },

  async getCourseProgress(userId, courseId) {
    const snapshot = await getDoc(doc(db, "users", userId));
    if (!snapshot.exists()) return null;

    const data = snapshot.data();
    const progressMap = data?.progress;

    if (!progressMap || !progressMap[courseId]) return null;

    return Progress.fromMap(progressMap[courseId]);
  },

  // -------- Calculer le progrès global --------

  async _updateGlobalProgress(userId) {
    const snapshot = await getDoc(doc(db, "users", userId));
    if (!snapshot.exists()) return;

    const data = snapshot.data();
    const progressMap = data?.progress;

    if (!progressMap || Object.keys(progressMap).length === 0) return;

    let total = 0;
    const keys = Object.keys(progressMap);

    keys.forEach((id) => {
      total += progressMap[id]?.percent || 0;
    });

    const globalProgress = total / keys.length;

    await updateDoc(doc(db, "users", userId), {
      globalProgress,
    });
  },

  // -------- Liste complète des utilisateurs --------

  async getAllUsers() {
    const q = query(collection(db, "users"), orderBy("createdAt"));
    const snapshot = await getDocs(q);

    return snapshot.docs.map((docSnap) => UserModel.fromFirestore(docSnap));
  },

  // -------- Recherche par rôle --------

  async getUsersByRole(role) {
    const q = query(
      collection(db, "users"),
      where("role", "==", role)
    );

    const snapshot = await getDocs(q);
    return snapshot.docs.map((docSnap) => UserModel.fromFirestore(docSnap));
  },

  // -------- Filtrer par nom/email --------

  async searchUsers(searchQuery) {
    const snapshot = await getDocs(collection(db, "users"));
    const lowerQuery = searchQuery.toLowerCase();

    return snapshot.docs
      .map((docSnap) => UserModel.fromFirestore(docSnap))
      .filter(
        (user) =>
          user.name.toLowerCase().includes(lowerQuery) ||
          user.email.toLowerCase().includes(lowerQuery)
      );
  },
};
