import React from 'react';

const styles = {
  header: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "30px",
    paddingBottom: "20px",
    borderBottom: "2px solid #e2e8f0",
    backgroundColor: "white",
    padding: "20px 30px",
    borderRadius: "12px",
    boxShadow: "0 2px 10px rgba(0,0,0,0.1)",
    marginLeft: "280px"
  },
  headerTitle: {
    fontSize: "28px",
    fontWeight: "bold",
    color: "#1e293b",
    margin: 0
  },
  userInfo: {
    display: "flex",
    alignItems: "center",
    gap: "15px",
    backgroundColor: "#f8fafc",
    padding: "12px 20px",
    borderRadius: "12px",
    border: "1px solid #e2e8f0"
  },
  userAvatar: {
    width: "45px",
    height: "45px",
    borderRadius: "50%",
    backgroundColor: "#2563eb",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    color: "white",
    fontWeight: "bold",
    fontSize: "18px"
  },
  userDetails: {
    display: "flex",
    flexDirection: "column"
  },
  userName: {
    fontWeight: "600",
    color: "#1e293b"
  },
  userRole: {
    color: "#64748b",
    fontSize: "14px"
  }
};

const getHeaderTitle = (activeTab) => {
  const titles = {
    'dashboard': 'Dashboard Overview',
    'courses': 'Course Management',
    'messaging': 'Messaging',
    'live': 'Live Sessions',
    'analytics': 'Analytics & Statistics',
    'settings': 'Settings & Preferences'
  };
  return titles[activeTab] || 'Dashboard';
};

export const Header = ({ activeTab }) => {
  return (
    <div style={styles.header}>
      <h1 style={styles.headerTitle}>{getHeaderTitle(activeTab)}</h1>
      <div style={styles.userInfo}>
        <div style={styles.userAvatar}>CM</div>
        <div style={styles.userDetails}>
          <div style={styles.userName}>Content Manager</div>
          <div style={styles.userRole}>Administrator</div>
        </div>
      </div>
    </div>
  );
};