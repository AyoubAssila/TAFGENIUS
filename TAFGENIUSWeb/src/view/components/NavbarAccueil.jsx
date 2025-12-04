// src/components/NavbarAccueil.jsx
import React from "react";
import { Link, useNavigate } from "react-router-dom";
import logo1 from "../../assets/logo1.png";

export default function NavbarAccueil() {
  const navigate = useNavigate();

  const handleHover = (e, hover) => {
    if (hover) {
      e.currentTarget.style.backgroundColor = "rgba(255, 255, 255, 0.1)";
      e.currentTarget.style.transform = "scale(1.1)";
    } else {
      e.currentTarget.style.backgroundColor = "";
      e.currentTarget.style.transform = "scale(1)";
    }
  };

  return (
    <header
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        padding: "16px 24px",
        backgroundColor: "#06112aff",
        borderBottom: "1px solid #06112aff",
        boxShadow: "0 2px 10px rgba(0,0,0,0.1)",
      }}
    >
      {/* Logo */}
      <div style={{ cursor: "pointer" }} onClick={() => navigate("/")}>
        <img src={logo1} alt="Logo" style={{ height: 50 }} />
      </div>

      {/* Nav Links */}
      <div style={{ display: "flex", justifyContent: "center", flex: 1, gap: "40px" }}>
        {["Home", "Blogs", "About"].map((item) => (
          <Link
            key={item}
            to={item === "Home" ? "/" : item === "Blogs" ? "/blogs-public" : "/aboutpublic"}
            onMouseEnter={(e) => handleHover(e, true)}
            onMouseLeave={(e) => handleHover(e, false)}
            style={{
              color: "white",
              textDecoration: "none",
              padding: "12px 20px",
              borderRadius: "8px",
              fontWeight: 600,
              transition: "all 0.3s ease",
            }}
          >
            {item}
          </Link>
        ))}
      </div>

      {/* Auth Buttons */}
      <div style={{ display: "flex", gap: "16px", alignItems: "center" }}>
        <button
          style={{
            backgroundColor: "transparent",
            color: "white",
            padding: "10px 24px",
            borderRadius: "6px",
            border: "1px solid white",
            fontWeight: 600,
            cursor: "pointer",
            transition: "all 0.3s ease",
          }}
          onClick={() => navigate("/login")}
          onMouseEnter={(e) => { e.currentTarget.style.backgroundColor = "rgba(255,255,255,0.1)"; }}
          onMouseLeave={(e) => { e.currentTarget.style.backgroundColor = "transparent"; }}
        >
          Log in
        </button>

        <button
          style={{
            backgroundColor: "white",
            color: "#06112aff",
            padding: "10px 24px",
            borderRadius: "6px",
            border: "none",
            fontWeight: "bold",
            cursor: "pointer",
            transition: "all 0.3s ease",
          }}
          onClick={() => navigate("/signup")}
          onMouseEnter={(e) => { e.currentTarget.style.backgroundColor = "#f3f4f6"; e.currentTarget.style.transform = "scale(1.05)"; }}
          onMouseLeave={(e) => { e.currentTarget.style.backgroundColor = "white"; e.currentTarget.style.transform = "scale(1)"; }}
        >
          Sign up
        </button>
      </div>
    </header>
  );
}
