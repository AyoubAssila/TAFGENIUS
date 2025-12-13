// src/viewmodels/dashboardViewModel.js
import { useState, useEffect, useCallback } from "react";
import { firestore } from "@src/firebaseConfig.js";
import { collection, getDocs } from "firebase/firestore";

/**
 * Hook pour gérer le Dashboard
 */
export function useDashboard() {
  const [users, setUsers] = useState([]);
  const usersCollection = collection(firestore, "users");

  // ----------- FETCH USERS -----------
  const fetchUsers = useCallback(async () => {
    try {
      const snapshot = await getDocs(usersCollection);
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
        return {
          id: docSnap.id,
          name: data.name || "",
          email: data.email || "",
          role: normalizeRole(data.role),
          status: data.status || "active",
          createdAt: data.createdAt?.toDate ? data.createdAt.toDate() : new Date(),
        };
      });
      setUsers(fetchedUsers);
    } catch (error) {
      console.error("Error fetching users:", error);
    }
  }, [usersCollection]);

  useEffect(() => {
    fetchUsers();
  }, [fetchUsers]);

  // ----------- MÉTRIQUES -----------
  const totalUsers = users.length;
  const activeStudentsCount = users.filter((u) => u.role === "student").length;
  const contentWebmastersCount = users.filter((u) => u.role === "content_webmaster").length;
  const technicalWebmastersCount = users.filter((u) => u.role === "technical_webmaster").length;
  const commercialCount = users.filter((u) => u.role === "commercial").length;

  return {
    users,
    fetchUsers,
    totalUsers,
    activeStudentsCount,
    contentWebmastersCount,
    technicalWebmastersCount,
    commercialCount,
  };
}
