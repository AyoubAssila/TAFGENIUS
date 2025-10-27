import React, { useState } from "react";
import { useNavigate } from "react-router-dom"; // ✅ importer useNavigate

export default function Navbar() {
  const [open, setOpen] = useState(false);
  const navigate = useNavigate(); // ✅ créer navigate

  return (
    <nav
      style={{
        height: 60,
        background: "#1976d2",
        color: "white",
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        padding: "0 24px",
        position: "fixed",
        top: 0,
        left: 0,
        right: 0,
        zIndex: 1000,
        boxShadow: "0 2px 6px rgba(0,0,0,0.08)",
        backfaceVisibility: "hidden",
        transform: "translateZ(0)",
        WebkitFontSmoothing: "antialiased",
        willChange: "transform",
      }}
    >
      {/* Logo */}
      <div style={{ fontWeight: 700, display: "flex", alignItems: "center", gap: 10 }}>
        <span style={{ fontSize: 20 }}>🎓</span>
        <span>AFTGenius</span>
      </div>

      {/* Liens centraux */}
      <div style={{ display: "flex", gap: 28, justifyContent: "center", flex: 1 }}>
        {["Home", "Blogs", "About"].map((item) => (
          <button
            key={item}
            onMouseEnter={(e) => (e.currentTarget.style.color = "#ffeb3b")}
            onMouseLeave={(e) => (e.currentTarget.style.color = "white")}
            onClick={() => alert(`${item} page coming soon`)}
            style={{
              background: "transparent",
              border: "none",
              color: "white",
              fontWeight: 600,
              cursor: "pointer",
              transition: "color 0.2s ease",
            }}
          >
            {item}
          </button>
        ))}
      </div>

      {/* Profil */}
      <div style={{ position: "relative" }}>
        <i
          className="bi bi-person-circle"
          onClick={() => setOpen((prev) => !prev)}
          style={{
            fontSize: 26,
            cursor: "pointer",
            color: "white",
            transition: "transform 0.2s",
          }}
          onMouseEnter={(e) => (e.currentTarget.style.transform = "scale(1.1)")}
          onMouseLeave={(e) => (e.currentTarget.style.transform = "scale(1)")}
        ></i>

        {open && (
  <div
    style={{
      position: "absolute",
      right: 0,
      top: 44,
      background: "white",
      color: "#222",
      borderRadius: 8,
      boxShadow: "0 6px 18px rgba(0,0,0,0.12)",
      overflow: "hidden",
      minWidth: 160,
    }}
  >
    {/* Edit Profile */}
    <div
      onClick={() => {
        navigate("/edit-profile");
        setOpen(false);
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.background = "#e0e0e0";
        e.currentTarget.style.transform = "scale(1.02)";
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.background = "white";
        e.currentTarget.style.transform = "scale(1)";
      }}
      style={{
        padding: "10px 14px",
        background: "white",
        color: "#111",
        cursor: "pointer",
        transition: "all 0.2s ease",
      }}
    >
      Edit Profile
    </div>

    {/* Log out */}
    <div
      onClick={() => {
        alert("Logged out");
        setOpen(false);
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.background = "#c62828";
        e.currentTarget.style.transform = "scale(1.02)";
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.background = "red";
        e.currentTarget.style.transform = "scale(1)";
      }}
      style={{
        padding: "10px 14px",
        background: "red",
        color: "white",
        cursor: "pointer",
        transition: "all 0.2s ease",
      }}
    >
      Log out
    </div>
  </div>
)}

      </div>
    </nav>
  );
}
