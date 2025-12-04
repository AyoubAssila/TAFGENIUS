import React from "react";
import { Link, useLocation } from "react-router-dom";

export default function Sidebar(){
  const location = useLocation();

  const items = [
    { name: "My Courses", path: "/mycourses", icon: "bi-book" },
    { name: "History", path: "/history", icon: "bi-clock-history" },
    { name: "Dashboard", path: "/dashboard", icon: "bi-speedometer2" },
  ];

  return (
    <aside style={{
      position: "fixed", top: 60, left: 0, bottom: 0, width: 220,
      background: "#f4f6f8", borderRight: "1px solid #e2e8f0", paddingTop: 20, zIndex: 900
    }}>

      {items.map(i => {
        const active = location.pathname === i.path;
        return (
          <Link
            key={i.path}
            to={i.path}
            style={{
              display: "flex", alignItems: "center", gap: 10,
              padding: "10px 16px", margin: "6px 8px", borderRadius: 8,
              textDecoration: "none",
              color: active ? "white" : "#333",
              background: active ? "#1976d2" : "transparent",
              transition: "all .15s ease"
            }}
            onMouseEnter={(e)=> { if(!active) e.currentTarget.style.background="#e8f4ff"; }}
            onMouseLeave={(e)=> { if(!active) e.currentTarget.style.background="transparent"; }}
          >
            <i className={`bi ${i.icon}`} style={{ fontSize: 18 }}></i>
            <span>{i.name}</span>
          </Link>
        );
      })}
    </aside>
  );
}
