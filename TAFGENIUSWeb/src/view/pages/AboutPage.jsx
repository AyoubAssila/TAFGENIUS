import React from "react";
import { useAboutViewModel } from "../../viewmodel/about_viewmodel";

// Composant réutilisable pour un membre de l'équipe
const TeamMemberCard = ({ member }) => (
  <div style={{
    display: "flex",
    alignItems: "center",
    padding: "12px",
    borderRadius: "12px",
    boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
    marginBottom: "12px"
  }}>
    <img
      src={member.imageUrl}
      alt={member.name}
      style={{ width: 64, height: 64, borderRadius: "50%" }}
    />
    <div style={{ marginLeft: 14 }}>
      <div style={{ fontWeight: "bold", fontSize: 16 }}>{member.name}</div>
      <div style={{ fontSize: 14, color: "#555" }}>{member.role}</div>
    </div>
  </div>
);

export const AboutPage = () => {
  const { sections, teamMembers } = useAboutViewModel();

  return (
    <div style={{ padding: 16, maxWidth: 800, margin: "0 auto" }}>
      <h1 style={{ textAlign: "center", fontSize: 26, color: "#007BFF" }}>About Us</h1>
      <div style={{ height: 20 }}></div>

      {sections.map((section, idx) => (
        <div key={idx} style={{ marginBottom: 20 }}>
          <h2 style={{ fontSize: 22, fontWeight: "bold" }}>{section.title}</h2>
          <div style={{ height: 8 }}></div>
          <div style={{
            padding: 14,
            borderRadius: 12,
            boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
            fontSize: 16,
            lineHeight: 1.5
          }}>
            {section.content}
          </div>
        </div>
      ))}

      <h2 style={{ fontSize: 22, fontWeight: "bold" }}>Our Team</h2>
      <div style={{ height: 12 }}></div>
      {teamMembers.map((member, idx) => (
        <TeamMemberCard key={idx} member={member} />
      ))}
    </div>
  );
};
export default AboutPage;