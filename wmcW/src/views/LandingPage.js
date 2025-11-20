import React from 'react';

const landingStyles = {
  container: {
    minHeight: "100vh",
    backgroundColor: "white",
    color: "#1f2937",
    fontFamily: "Arial, sans-serif",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
  },
  dashboardButton: {
    backgroundColor: "#2563eb",
    color: "white",
    padding: "15px 30px",
    border: "none",
    borderRadius: "8px",
    cursor: "pointer",
    fontWeight: "600",
    fontSize: "16px",
    marginTop: "30px",
    transition: "all 0.3s ease"
  },
  title: {
    fontSize: "48px",
    fontWeight: "bold",
    color: "white",
    marginBottom: "20px",
    textAlign: "center"
  },
  subtitle: {
    fontSize: "20px",
    color: "rgba(255,255,255,0.8)",
    textAlign: "center",
    maxWidth: "600px"
  }
};

export const LandingPage = ({ onNavigateToDashboard }) => {
  return (
    <div style={landingStyles.container}>
      <h1 style={landingStyles.title}>AFTGENIUS Platform</h1>
      <p style={landingStyles.subtitle}>
        Manage your courses, interact with students, and track analytics all in one place
      </p>
      <button 
        onClick={onNavigateToDashboard}
        style={landingStyles.dashboardButton}
        onMouseEnter={(e) => e.target.style.transform = "scale(1.05)"}
        onMouseLeave={(e) => e.target.style.transform = "scale(1)"}
      >
        Access Dashboard
      </button>
    </div>
  );
};