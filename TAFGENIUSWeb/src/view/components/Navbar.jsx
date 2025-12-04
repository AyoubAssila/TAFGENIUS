
import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { FaUserCircle } from "react-icons/fa";
import logo1 from "../../assets/logo1.png";

export default function Navbar() {
  const [open, setOpen] = useState(false);
  const navigate = useNavigate();

  return (
    <nav
      style={{
        height: 70,
        background: "#06112aff",
        color: "white",
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        padding: "0 32px",
        position: "fixed",
        top: 0,
        left: 0,
        right: 0,
        zIndex: 1000,
        boxShadow: "0 2px 10px rgba(0,0,0,0.15)",
        borderBottom: "1px solid #06112aff",
      }}
    >
      {/* Logo */}
      <div style={{ cursor: "pointer" }} onClick={() => navigate("/")}>
        <img src={logo1} alt="Logo" style={{ height: 50 }} />
      </div>

      {/* Navigation */}
      <div style={{ display: "flex", gap: 40 }}>
        {["Home", "Blogs", "About"].map((item) => (
          <button
            key={item}
            onClick={() => {
              if (item === "Home") navigate("/");
              else if (item === "Blogs") navigate("/blogs");
              else if (item === "About") navigate("/about");
            }}
            onMouseEnter={(e) => (e.currentTarget.style.background = "rgba(255,255,255,0.15)")}
            onMouseLeave={(e) => (e.currentTarget.style.background = "transparent")}
            style={{
              background: "transparent",
              border: "none",
              color: "white",
              fontWeight: 600,
              fontSize: 17,
              cursor: "pointer",
              padding: "10px 20px",
              borderRadius: 8,
              transition: "all 0.3s ease",
            }}
          >
            {item}
          </button>
        ))}
      </div>

      {/* Icône utilisateur */}
      <div style={{ position: "relative" }}>
        <FaUserCircle
          onClick={() => setOpen((prev) => !prev)}
          style={{
            fontSize: 30,
            cursor: "pointer",
            color: "white",
            transition: "transform 0.2s ease, color 0.3s ease",
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = "scale(1.1)";
            e.currentTarget.style.color = "#ffeb3b";
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = "scale(1)";
            e.currentTarget.style.color = "white";
          }}
        />

        {open && (
          <div
            style={{
              position: "absolute",
              right: 0,
              top: 44,
              background: "white",
              color: "#222",
              borderRadius: 10,
              boxShadow: "0 6px 18px rgba(0,0,0,0.12)",
              overflow: "hidden",
              minWidth: 160,
              zIndex: 1000,
            }}
          >
            <div
              onClick={() => {
                navigate("/edit-profile");
                setOpen(false);
              }}
              onMouseEnter={(e) => (e.currentTarget.style.background = "#e5e7eb")}
              onMouseLeave={(e) => (e.currentTarget.style.background = "white")}
              style={{
                padding: "10px 14px",
                background: "white",
                color: "#111",
                cursor: "pointer",
                fontWeight: 500,
                transition: "all 0.3s ease",
              }}
            >
              Edit Profile
            </div>

            <div
              onClick={() => {
                alert("Logged out");
                setOpen(false);
              }}
              onMouseEnter={(e) => (e.currentTarget.style.background = "#dc2626")}
              onMouseLeave={(e) => (e.currentTarget.style.background = "#ef4444")}
              style={{
                padding: "10px 14px",
                background: "#ef4444",
                color: "white",
                cursor: "pointer",
                fontWeight: 500,
                transition: "all 0.3s ease",
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
