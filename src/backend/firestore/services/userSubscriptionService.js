// src/services/UserSubscriptionService.js
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
  serverTimestamp,
} from "firebase/firestore";
import { db } from "../../../firebaseConfig.js";
import { UserSubscriptionModel } from "../../../model/UserSubscriptionModel.js";

export const UserSubscriptionService = {
  // -------- CREATE --------
  async createSubscription(subscription) {
    if (!subscription.id) {
      // Générer un nouvel ID via doc() si pas défini
      const docRef = doc(collection(db, "userSubscriptions"));
      subscription.id = docRef.id;
      await setDoc(docRef, {
        ...subscription.toMap(),
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp(),
      });
    } else {
      await setDoc(doc(db, "userSubscriptions", subscription.id), {
        ...subscription.toMap(),
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp(),
      });
    }
    return subscription;
  },

  // -------- READ --------
  async getSubscription(id) {
    const snapshot = await getDoc(doc(db, "userSubscriptions", id));
    if (!snapshot.exists()) return null;
    return UserSubscriptionModel.fromMap(snapshot.data(), snapshot.id);
  },

  async getSubscriptionsByUser(userId) {
    const q = query(
      collection(db, "userSubscriptions"),
      where("userId", "==", userId),
      orderBy("activatedAt", "desc")
    );
    const snapshot = await getDocs(q);
    return snapshot.docs.map(docSnap => UserSubscriptionModel.fromMap(docSnap.data(), docSnap.id));
  },

  async getAllSubscriptions() {
    const snapshot = await getDocs(query(collection(db, "userSubscriptions"), orderBy("activatedAt", "desc")));
    return snapshot.docs.map(docSnap => UserSubscriptionModel.fromMap(docSnap.data(), docSnap.id));
  },

  // -------- UPDATE --------
  async updateSubscription(id, data) {
    const updatedData = {
      ...data,
      updatedAt: serverTimestamp(),
    };
    await updateDoc(doc(db, "userSubscriptions", id), updatedData);
  },

  // -------- DELETE --------
  async deleteSubscription(id) {
    await deleteDoc(doc(db, "userSubscriptions", id));
  },

  // -------- ACTIVATE / DEACTIVATE --------
  async toggleActive(id) {
    const subscription = await this.getSubscription(id);
    if (!subscription) return null;
    const newActive = !subscription.active;
    await updateDoc(doc(db, "userSubscriptions", id), {
      active: newActive,
      updatedAt: serverTimestamp(),
    });
    subscription.active = newActive;
    return subscription;
  },
};
