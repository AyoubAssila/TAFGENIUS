import React, { useState } from "react";
import Navbar from "../components/Navbar";

import DashboardPage from "./DashboardPage";
import MyCoursesPage from "./MyCoursesPage";
import HistoryPage from "./HistoryPage";

export default function EtudiantPage() {
  const [selectedIndex, setSelectedIndex] = useState(0);
  const pages = [<DashboardPage />, <MyCoursesPage />, <HistoryPage />];

  return (
    <div>
      <Navbar />
      {pages[selectedIndex]}
      <div style={{ position: "fixed", bottom: 0, width: "100%", display: "flex", justifyContent: "space-around", padding: "10px 0", background: "#fff", boxShadow: "0px -2px 5px rgba(0,0,0,0.1)" }}>
        {["Dashboard", "My Courses", "History"].map((label, i) => (
          <button key={label} onClick={() => setSelectedIndex(i)} style={{ border: "none", background: "transparent", cursor: "pointer", color: selectedIndex === i ? "#1976d2" : "grey" }}>
            {label}
          </button>
        ))}
      </div>
    </div>
  );
}
