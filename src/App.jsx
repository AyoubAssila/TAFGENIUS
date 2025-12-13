// src/App.jsx
import React, { useEffect, useState } from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";

import { getAuth, onAuthStateChanged } from "firebase/auth";
import { firestore } from "./firebaseConfig";
import { doc, getDoc } from "firebase/firestore";

// Pages
import DashboardPage from "./view/pages/dashboard.jsx";
import UsersPage from "./view/pages/user.jsx";
import LogPage from "./view/pages/log.jsx";
import LoginPage from "./view/pages/login.jsx";

export default function App() {
  const [currentUser, setCurrentUser] = useState(null);
  const [userRole, setUserRole] = useState(null);
  const auth = getAuth();

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setCurrentUser(user);
      if (user) {
        (async () => {
          try {
            const snap = await getDoc(doc(firestore, "users", user.uid));
            const mapRole = (raw) => {
              const cleaned = (raw || "").toString().trim().toLowerCase();
              if (!cleaned) return "student";
              if (["etudiant", "student"].includes(cleaned)) return "student";
              if (["webmaster_contenu", "content_webmaster", "webmaster contenu"].includes(cleaned)) return "content_webmaster";
              if (["webmaster_technique", "technical_webmaster", "webmaster technique"].includes(cleaned)) return "technical_webmaster";
              if (["commercial"].includes(cleaned)) return "commercial";
              return cleaned.replace(/\s|-/g, "_");
            };
            const role = mapRole(snap.data()?.role);
            setUserRole(role);
          } catch {
            setUserRole("student");
          }
        })();
      } else {
        setUserRole(null);
      }
    });
    return unsubscribe;
  }, [auth]);

  const isAdmin = (role) =>
    role === "content_webmaster" || role === "technical_webmaster" || role === "commercial";

  return (
    <Router>
      <Routes>
        <Route path="/login" element={<LoginPage />} />

        {/* Admin Technique */}
        <Route
          path="/admin-technique/dashboard"
          element={currentUser ? <DashboardPage /> : <Navigate to="/login" />}
        />
        <Route
          path="/admin-technique/users"
          element={
            currentUser
              ? (isAdmin(userRole) ? <UsersPage /> : <Navigate to="/etudiant/dashboard" />)
              : <Navigate to="/login" />
          }
        />
        <Route
          path="/admin-technique/logs"
          element={
            currentUser
              ? (isAdmin(userRole) ? <LogPage /> : <Navigate to="/etudiant/dashboard" />)
              : <Navigate to="/login" />
          }
        />

        {/* Étudiant */}
        <Route
          path="/etudiant/dashboard"
          element={
            currentUser
              ? (userRole === "student" ? <DashboardPage /> : <Navigate to="/admin-technique/dashboard" />)
              : <Navigate to="/login" />
          }
        />

        {/* Redirect root */}
        <Route
          path="/"
          element={
            currentUser
              ? <Navigate to={isAdmin(userRole) ? "/admin-technique/dashboard" : "/etudiant/dashboard"} />
              : <Navigate to="/login" />
          }
        />
      </Routes>
    </Router>
  );
}
