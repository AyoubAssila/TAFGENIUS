import React from 'react';

const styles = {
  sidebar: {
    width: "280px",
    backgroundColor: "#2563eb",
    color: "white",
    padding: "20px 0",
    minHeight: "100vh",
    boxShadow: "2px 0 10px rgba(0,0,0,0.1)",
    position: "fixed",
    left: 0,
    top: 0,
    bottom: 0,
    overflowY: "auto",
    background: `
      #2563eb,
      radial-gradient(circle at top right, rgba(37, 99, 235, 0.8) 0%, transparent 50%),
      radial-gradient(circle at bottom left, rgba(255, 255, 255, 0.1) 0%, transparent 50%)
    `,
    backgroundBlendMode: "overlay"
  },
  logo: {
    fontSize: "24px",
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: "40px",
    padding: "0 20px",
    color: "white",
    textShadow: "0 2px 4px rgba(0,0,0,0.2)"
  },
  menu: {
    listStyle: "none",
    padding: 0,
    margin: 0
  },
  menuItem: {
    padding: "15px 25px",
    cursor: "pointer",
    transition: "all 0.3s ease",
    display: "flex",
    alignItems: "center",
    gap: "12px",
    fontSize: "16px",
    borderLeft: "4px solid transparent",
    marginBottom: "5px",
    color: "rgba(255,255,255,0.9)",
    position: "relative",
    overflow: "hidden"
  },
  menuItemActive: {
    backgroundColor: "rgba(255,255,255,0.15)",
    borderLeft: "4px solid #ffffff",
    color: "#ffffff",
    textShadow: "0 0 10px rgba(255,255,255,0.3)"
  },
  menuItemHover: {
    backgroundColor: "rgba(255,255,255,0.1)",
    transform: "translateX(5px)"
  },
  menuIcon: {
    fontSize: "18px",
    width: "24px",
    textAlign: "center",
    filter: "drop-shadow(0 1px 2px rgba(0,0,0,0.2))"
  },
  menuText: {
    fontWeight: "500",
    letterSpacing: "0.3px",
    textShadow: "0 1px 2px rgba(0,0,0,0.2)"
  },
  menuItemGlow: {
    position: "absolute",
    top: 0,
    left: "-100%",
    width: "100%",
    height: "100%",
    background: "linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent)",
    transition: "left 0.5s ease"
  }
};

const menuItems = [
  { id: "dashboard", label: "Dashboard" },
  { id: "courses", label: "Manage Courses" },
  { id: "messaging", label: "Messaging"},
  { id: "live", label: "Live Sessions" },
  { id: "analytics", label: "Analytics"},
  { id: "settings", label: "Settings"}
];

export const Sidebar = ({ activeTab, onTabChange, onNavigateToHome }) => {
  const [hoveredItem, setHoveredItem] = React.useState(null);

  const handleTabClick = (tabId) => {
    onTabChange(tabId);
  };

  return (
    <div style={styles.sidebar}>
      <div style={styles.logo}>AFTGENIUS</div>
      <ul style={styles.menu}>
        {menuItems.map(item => (
          <li
            key={item.id}
            style={{
              ...styles.menuItem,
              ...(activeTab === item.id ? styles.menuItemActive : {}),
              ...(hoveredItem === item.id ? styles.menuItemHover : {})
            }}
            onClick={() => handleTabClick(item.id)}
            onMouseEnter={() => setHoveredItem(item.id)}
            onMouseLeave={() => setHoveredItem(null)}
          >
            {hoveredItem === item.id && (
              <div 
                style={{
                  ...styles.menuItemGlow,
                  left: hoveredItem === item.id ? "100%" : "-100%"
                }} 
              />
            )}
            <span style={styles.menuIcon}>{item.icon}</span>
            <span style={styles.menuText}>{item.label}</span>
          </li>
        ))}
        
        {/* Séparateur */}
        <div style={{
          height: "1px",
          backgroundColor: "rgba(255,255,255,0.2)",
          margin: "20px 25px",
          borderRadius: "2px"
        }} />
        
        <li
          style={{
            ...styles.menuItem,
            ...(hoveredItem === 'home' ? styles.menuItemHover : {})
          }}
          onClick={onNavigateToHome}
          onMouseEnter={() => setHoveredItem('home')}
          onMouseLeave={() => setHoveredItem(null)}
        >
          {hoveredItem === 'home' && (
            <div 
              style={{
                ...styles.menuItemGlow,
                left: hoveredItem === 'home' ? "100%" : "-100%"
              }} 
            />
          )}
          <span style={styles.menuIcon}></span>
          <span style={styles.menuText}>Back to Site</span>
        </li>
      </ul>

      {/* Footer de la sidebar */}
      <div style={{
        position: "absolute",
        bottom: "20px",
        left: "0",
        right: "0",
        textAlign: "center",
        color: "rgba(255,255,255,0.7)",
        fontSize: "12px",
        padding: "0 20px",
        textShadow: "0 1px 2px rgba(0,0,0,0.2)"
      }}>
        <div style={{ marginBottom: "5px" }}>AFTGENIUS Platform</div>
        <div>© 2025 All rights reserved</div>
      </div>
    </div>
  );
};