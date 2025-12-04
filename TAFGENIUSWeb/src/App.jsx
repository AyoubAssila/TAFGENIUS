import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";

// ----------------- Layout Components -----------------
import Navbar from "./view/components/Navbar"; // Navbar étudiant
import NavbarAccueil from "./view/components/NavbarAccueil.jsx"; // Navbar visiteurs
import Sidebar from "./view/components/Sidebar";
import Footer from "./view/components/Footer"; // Footer public

// ----------------- Pages publiques -----------------
import HomePage from "./view/pages/HomePage";
import BlogPublicPage from "./view/pages/BlogPublicPage";
import AboutPublicPage from "./view/pages/AboutPublicPage";
import SignupPage from "./view/pages/SignupPage";
import LoginPage from "./view/pages/LoginPage";

// ----------------- Pages étudiants -----------------
import AboutPage from "./view/pages/AboutPage";
import BlogsPage from "./view/pages/BlogPage";
import EtudiantPage from "./view/pages/EtudiantPage";
import MyCoursesPage from "./view/pages/MyCoursesPage";
import HistoryPage from "./view/pages/HistoryPage";
import DashboardPage from "./view/pages/DashboardPage";
import CourseDetailPage from "./view/pages/CourseDetailPage";
import EditProfilePage from "./view/pages/EditProfilePage";

// ----------------- Layout: Public -----------------
function PublicLayout({ children }) {
  return (
    <div style={{ minHeight: "100vh", display: "flex", flexDirection: "column" }}>
      <NavbarAccueil />
      <div style={{ flex: 1 }}>{children}</div>
      <Footer />
    </div>
  );
}

// ----------------- Layout: Étudiant -----------------
function EtudiantLayout({ children }) {
  return (
    <div style={{ display: "flex", minHeight: "100vh" }}>
      <Sidebar />
      <div style={{ flex: 1 }}>
        <Navbar />
        <div style={{ padding: "20px", marginTop: "60px" }}>{children}</div>
      </div>
    </div>
  );
}

// ----------------- AppContent -----------------
function AppContent() {
  return (
    <Routes>
      {/* Pages publiques */}
      <Route path="/" element={<PublicLayout><HomePage /></PublicLayout>} />
      <Route path="/blogs-public" element={<PublicLayout><BlogPublicPage /></PublicLayout>} />
      <Route path="/aboutpublic" element={<PublicLayout><AboutPublicPage /></PublicLayout>} />
      <Route path="/signup" element={<PublicLayout><SignupPage /></PublicLayout>} />
      <Route path="/login" element={<PublicLayout><LoginPage /></PublicLayout>} />

      {/* Pages étudiantes */}
      <Route path="/about" element={<EtudiantLayout><AboutPage /></EtudiantLayout>} />
      <Route path="/blogs" element={<EtudiantLayout><BlogsPage /></EtudiantLayout>} />
      <Route path="/etudiant" element={<EtudiantLayout><EtudiantPage /></EtudiantLayout>} />
      <Route path="/mycourses" element={<EtudiantLayout><MyCoursesPage /></EtudiantLayout>} />
      <Route path="/history" element={<EtudiantLayout><HistoryPage /></EtudiantLayout>} />
      <Route path="/dashboard" element={<EtudiantLayout><DashboardPage /></EtudiantLayout>} />
      <Route path="/coursedetail" element={<EtudiantLayout><CourseDetailPage /></EtudiantLayout>} />
      <Route path="/edit-profile" element={<EtudiantLayout><EditProfilePage /></EtudiantLayout>} />

      {/* 404 */}
      <Route path="*" element={<div>Page not found</div>} />
    </Routes>
  );
}

// ----------------- App -----------------
export default function App() {
  return (
    <BrowserRouter>
      <AppContent />
    </BrowserRouter>
  );
}
