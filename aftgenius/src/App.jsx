import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";

import DashboardPage from "./pages/DashboardPage";
import MyCoursesPage from "./pages/MyCoursesPage";
import HistoryPage from "./pages/HistoryPage";
import EtudiantPage from "./pages/EtudiantPage";
import CourseDetailPage from "./pages/CourseDetailPage";
import EditProfilePage from "./pages/EditProfilePage";

export default function App() {
  return (
    <BrowserRouter>
      {/* Navbar toujours en premier */}
      <Navbar />

      <div style={{ display: "flex", minHeight: "100vh", paddingTop: 60 }}>
        {/* Sidebar */}
        <Sidebar />

        {/* Contenu principal */}
        <div style={{ flex: 1, padding: "20px" }}>
          <Routes>
            <Route path="/" element={<EtudiantPage />} />
            <Route path="/dashboard" element={<DashboardPage />} />
            <Route path="/mycourses" element={<MyCoursesPage />} />
            <Route path="/history" element={<HistoryPage />} />
            <Route path="/coursedetail" element={<CourseDetailPage />} />
            <Route path="/edit-profile" element={<EditProfilePage />} />
          </Routes>
        </div>
      </div>
    </BrowserRouter>
  );
}
