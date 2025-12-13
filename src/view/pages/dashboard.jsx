// src/views/pages/Dashboard.jsx
import React from "react";
import { useDashboard } from "@viewModel/DashboardViewModel.js";
import Stats from "@components/stats.jsx";
import Sidebar from "@components/sidebar.jsx";

export default function Dashboard() {
  const {
    users,
    totalUsers,
    activeStudentsCount,
    contentWebmastersCount,
    technicalWebmastersCount,
    commercialCount,
  } = useDashboard();

  return (
    <div className="d-flex min-vh-100">
      <Sidebar />
      <div style={{ padding: "20px", flex: 1, height: "100vh", overflowY: "auto", overflowX: "hidden" }}>
      <div style={{ display: "flex", gap: "20px", marginBottom: "20px" }}>
        <Stats title="Total Users" value={totalUsers} />
        <Stats title="Students" value={activeStudentsCount} />
        <Stats title="Content Webmasters" value={contentWebmastersCount} />
        <Stats title="Technical Webmasters" value={technicalWebmastersCount} />
        <Stats title="Commercial" value={commercialCount} />
      </div>

      <div style={{ background: "#fff", padding: "16px", borderRadius: "8px" }}>
        <h2>Latest Registered Users</h2>
        {users.length === 0 ? (
          <div style={{ textAlign: "center", padding: "20px" }}>Loading...</div>
        ) : (
          <div style={{ overflowX: "auto" }}>
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead>
                <tr>
                  <th style={{ borderBottom: "1px solid #ccc", padding: "8px" }}>Name</th>
                  <th style={{ borderBottom: "1px solid #ccc", padding: "8px" }}>Email</th>
                  <th style={{ borderBottom: "1px solid #ccc", padding: "8px" }}>Date Joined</th>
                </tr>
              </thead>
              <tbody>
                {users.map((user) => (
                  <tr key={user.id}>
                    <td style={{ borderBottom: "1px solid #eee", padding: "8px" }}>{user.name}</td>
                    <td style={{ borderBottom: "1px solid #eee", padding: "8px" }}>{user.email}</td>
                    <td style={{ borderBottom: "1px solid #eee", padding: "8px" }}>
                      {user.createdAt.toLocaleDateString()}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
      </div>
    </div>
  );
}
