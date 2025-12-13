// src/viewmodels/usersViewModel.js
import { useState, useEffect, useCallback, useMemo } from "react";
import { firestore } from "@src/firebaseConfig.js";
import { SubscriptionService } from "@backend/firestore/services/subscriptionService.js";
import {
  collection,
  getDocs,
  addDoc,
  deleteDoc,
  doc,
  updateDoc,
  query,
  orderBy,
} from "firebase/firestore";

/**
 * Hook pour gérer les utilisateurs
 */
export default function useUsers()  {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState("");
  const [roleFilter, setRoleFilter] = useState("all");
  const usersCollection = collection(firestore, "users");

  // ----------- FETCH USERS -----------
  const fetchUsers = useCallback(async () => {
    try {
      const q = query(usersCollection, orderBy("createdAt", "desc"));
      const snapshot = await getDocs(q);

      const normalizeRole = (raw) => {
        const cleaned = (raw || "").toString().trim().toLowerCase();
        if (!cleaned) return "student";
        if (["etudiant", "student"].includes(cleaned)) return "student";
        if (["webmaster_contenu", "content_webmaster", "webmaster contenu"].includes(cleaned)) return "content_webmaster";
        if (["webmaster_technique", "technical_webmaster", "webmaster technique"].includes(cleaned)) return "technical_webmaster";
        if (["commercial"].includes(cleaned)) return "commercial";
        return cleaned.replace(/\s|-/g, "_");
      };

      const fetchedUsers = snapshot.docs.map((docSnap) => {
        const data = docSnap.data();
        const role = normalizeRole(data.role);
        const defaultStatus = role === "student" ? "inactive" : "active";
        return {
          id: docSnap.id,
          name: data.name || "",
          email: data.email || "",
          status: data.status || defaultStatus,
          role,
          createdAt: data.createdAt?.toDate ? data.createdAt.toDate() : new Date(),
        };
      });

      setUsers(fetchedUsers);
    } catch (error) {
      console.error("Erreur fetchUsers:", error);
    }
  }, [usersCollection]);

  useEffect(() => {
    fetchUsers();
  }, [fetchUsers]);

  // ----------- SEARCH FILTER (derived) ----------
  const filteredUsers = useMemo(() => {
    const q = search.trim().toLowerCase();
    const rf = roleFilter;
    return users.filter((u) => {
      const matchesSearch =
        !q ||
        u.name.toLowerCase().includes(q) ||
        u.email.toLowerCase().includes(q);
      const matchesRole = rf === "all" || (u.role && u.role === rf);
      return matchesSearch && matchesRole;
    });
  }, [users, search, roleFilter]);

  // ----------- ADD USER ----------
  const addUser = async (user) => {
    try {
      const docRef = await addDoc(usersCollection, {
        ...user,
        createdAt: new Date(),
      });
      const newUser = { ...user, id: docRef.id };
      setUsers((prev) => [newUser, ...prev]);
    } catch (error) {
      console.error("Erreur addUser:", error);
    }
  };

  // ----------- DELETE USER ----------
  const deleteUser = async (userId) => {
    try {
      await deleteDoc(doc(usersCollection, userId));
      setUsers((prev) => prev.filter((u) => u.id !== userId));
    } catch (error) {
      console.error("Erreur deleteUser:", error);
    }
  };

  // ----------- TOGGLE STATUS ----------
  const toggleStatus = async (userId) => {
    try {
      const user = users.find((u) => u.id === userId);
      if (!user) return;
      if (user.role === "student") {
        const res = await SubscriptionService.updateUserStatusProtected(userId, user.status);
        if (!res?.ok) return;
      }
      const newStatus = "active";
      await updateDoc(doc(usersCollection, userId), { status: newStatus });
      const updatedUser = { ...user, status: newStatus };
      setUsers((prev) =>
        prev.map((u) => (u.id === userId ? updatedUser : u))
      );
      // filteredUsers is derived; no direct update
    } catch (error) {
      console.error("Erreur toggleStatus:", error);
    }
  };

  // ----------- STATUS STYLE ----------
  const getStatusStyle = (status) => {
    const s = (status || "").toLowerCase();
    if (s === "active" || s === "subscribed") return { color: "#198754", icon: "check" };
    if (s === "inactive") return { color: "#dc3545", icon: "times" };
    return { color: "#6c757d", icon: "clock" };
  };

  return {
    users,
    filteredUsers,
    search,
    setSearch,
    roleFilter,
    setRoleFilter,
    fetchUsers,
    addUser,
    deleteUser,
    toggleStatus,
    getStatusStyle,
  };
}
