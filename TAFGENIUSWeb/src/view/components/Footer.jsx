import React from "react";

export default function Footer() {
  const styles = {
    footer: {
      padding: "30px 24px",
      backgroundColor: "#06112aff",
      textAlign: "center",
      fontSize: "16px",
      color: "white",
      marginTop: "40px"
    },
    footerLinks: {
      display: "flex",
      justifyContent: "center",
      gap: "30px",
      marginBottom: "16px",
      fontSize: "16px",
      flexWrap: "wrap"
    }
  };

  return (
    <footer style={styles.footer}>
      <div style={styles.footerLinks}>
        <span>Contact</span>
        <span>Legal Notice</span>
        <span>Useful Links</span>
        <span>Social Media</span>
      </div>
      <div>AFTGENIUS - Your Excellence Training Partner</div>
    </footer>
  );
}
