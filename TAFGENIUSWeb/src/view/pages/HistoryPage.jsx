// src/View/Pages/HistoryPage.jsx
import React from "react";
import Navbar from "../components/Navbar";
import Sidebar from "../components/Sidebar";
import useHistoryViewModel from "../../viewmodel/history_viewmodel";


export default function HistoryPage() {
  const { tab, setTab, getTabData } = useHistoryViewModel();

  const cardStyle = {
    background: "white",
    padding: "16px",
    borderRadius: "10px",
    boxShadow: "0px 2px 6px rgba(0,0,0,0.1)",
    marginBottom: "12px",
  };

  const renderTab = () => {
    const data = getTabData();
    switch (tab) {
      case "Courses":
        return data.map((c, i) => (
          <div key={i} style={cardStyle}>
            <h4>{c.title}</h4>
            <p>Progress: {c.progress}</p>
          </div>
        ));
      case "Quizzes":
        return data.map((q, i) => (
          <div key={i} style={cardStyle}>
            <h4>{q.title}</h4>
            <p>Score: {q.score}</p>
          </div>
        ));
      case "Certificates":
        return data.map((c, i) => (
          <div key={i} style={cardStyle}>
            <h4>{c.title}</h4>
            <p>Issued: {c.date}</p>
          </div>
        ));
      case "Payments":
        return data.map((p, i) => (
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
      <div style={{ marginLeft: "300px", marginTop: "50px", maxWidth: "800px" }}>
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
                background: tab === item ? "#2563eb" : "#ddd",
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
