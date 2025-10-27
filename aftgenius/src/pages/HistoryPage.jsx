import React, { useState } from "react";
import { useLocation } from "react-router-dom";
import Navbar from "../components/Navbar";
import Sidebar from "../components/Sidebar";

export default function HistoryPage() {
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const tabParam = params.get("tab")?.toLowerCase() || "quizzes";

  const [tab, setTab] = useState(() => {
    switch (tabParam) {
      case "courses":
        return "Courses";
      case "quizzes":
        return "Quizzes";
      case "certificates":
        return "Certificates";
      case "payments":
        return "Payments";
      default:
        return "Quizzes";
    }
  });

  const cardStyle = {
    background: "white",
    padding: "16px",
    borderRadius: "10px",
    boxShadow: "0px 2px 6px rgba(0,0,0,0.1)",
    marginBottom: "12px",
  };

  const renderTab = () => {
    switch (tab) {
      case "Courses":
        return [
          { title: "React Basics", progress: "70%" },
          { title: "Python Intermediate", progress: "50%" },
        ].map((c, i) => (
          <div key={i} style={cardStyle}>
            <h4>{c.title}</h4>
            <p>Progress: {c.progress}</p>
          </div>
        ));
      case "Quizzes":
        return [
          { title: "Python Basics Quiz", score: "85%" },
          { title: "UI/UX Principles", score: "90%" },
        ].map((q, i) => (
          <div key={i} style={cardStyle}>
            <h4>{q.title}</h4>
            <p>Score: {q.score}</p>
          </div>
        ));
      case "Certificates":
        return [
          { title: "React Certificate", date: "May 2024" },
          { title: "Python Programming", date: "June 2024" },
        ].map((c, i) => (
          <div key={i} style={cardStyle}>
            <h4>{c.title}</h4>
            <p>Issued: {c.date}</p>
          </div>
        ));
      case "Payments":
        return [
          { id: "#12345", amount: "40 TND", date: "May 10, 2024" },
          { id: "#12346", amount: "50 TND", date: "June 2, 2024" },
        ].map((p, i) => (
          <div key={i} style={cardStyle}>
            <h4>Invoice {p.id}</h4>
            <p>{p.amount} — {p.date}</p>
          </div>
        ));
      default:
        return null;
    }
  };

  return (
    <>
      <Navbar />
      <Sidebar />
      <div
        style={{
          marginLeft: "300px",
          marginTop: "50px",
          maxWidth: "800px",
        }}
      >
        <h2>🕓 History</h2>

        <div style={{ display: "flex", gap: "10px", margin: "16px 0" }}>
          {["Courses", "Quizzes", "Certificates", "Payments"].map((item) => (
            <button
              key={item}
              onClick={() => setTab(item)}
              style={{
                padding: "8px 16px",
                borderRadius: "20px",
                border: "none",
                background: tab === item ? "#1976d2" : "#ddd",
                color: tab === item ? "white" : "black",
                cursor: "pointer",
              }}
            >
              {item}
            </button>
          ))}
        </div>

        {renderTab()}
      </div>
    </>
  );
}
