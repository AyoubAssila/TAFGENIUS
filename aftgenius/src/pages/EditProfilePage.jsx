import React, { useState } from "react";

export default function EditProfilePage() {
  const [username, setUsername] = useState("JohnDoe");
  const [email, setEmail] = useState("johndoe@example.com");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [message, setMessage] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();

    // Basic validation
    if (!username || !email || !password || !confirmPassword) {
      setMessage("All fields are required.");
      return;
    }

    if (!/\S+@\S+\.\S+/.test(email)) {
      setMessage("Please enter a valid email address.");
      return;
    }

    if (password !== confirmPassword) {
      setMessage("Passwords do not match.");
      return;
    }

    // Simulate saving data
    setMessage("Profile updated successfully!");
    console.log({ username, email, password });
    setPassword("");
    setConfirmPassword("");
  };

  return (
    <div style={{ maxWidth: 500, margin: "50px auto", padding: 20, background: "#fff", borderRadius: 8, boxShadow: "0 2px 10px rgba(0,0,0,0.1)" }}>
      <h2 style={{ marginBottom: 20 }}>Edit Profile</h2>

      {message && (
        <div style={{
          marginBottom: 15,
          padding: 10,
          borderRadius: 5,
          background: message.includes("success") ? "#d4edda" : "#f8d7da",
          color: message.includes("success") ? "#155724" : "#721c24"
        }}>
          {message}
        </div>
      )}

      <form onSubmit={handleSubmit}>
        {/* Username */}
        <div style={{ marginBottom: 15 }}>
          <label htmlFor="username" style={{ display: "block", marginBottom: 5 }}>Username</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            style={{ width: "100%", padding: 10, borderRadius: 5, border: "1px solid #ccc" }}
          />
        </div>

        {/* Email */}
        <div style={{ marginBottom: 15 }}>
          <label htmlFor="email" style={{ display: "block", marginBottom: 5 }}>Email</label>
          <input
            type="email"
            id="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            style={{ width: "100%", padding: 10, borderRadius: 5, border: "1px solid #ccc" }}
          />
        </div>

        {/* New Password */}
        <div style={{ marginBottom: 15 }}>
          <label htmlFor="password" style={{ display: "block", marginBottom: 5 }}>New Password</label>
          <input
            type="password"
            id="password"
            placeholder="Enter new password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            style={{ width: "100%", padding: 10, borderRadius: 5, border: "1px solid #ccc" }}
          />
        </div>

        {/* Confirm New Password */}
        <div style={{ marginBottom: 20 }}>
          <label htmlFor="confirmPassword" style={{ display: "block", marginBottom: 5 }}>Confirm New Password</label>
          <input
            type="password"
            id="confirmPassword"
            placeholder="Confirm your new password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            style={{ width: "100%", padding: 10, borderRadius: 5, border: "1px solid #ccc" }}
          />
        </div>

        <button type="submit" style={{ padding: "10px 20px", background: "#1976d2", color: "#fff", border: "none", borderRadius: 5, cursor: "pointer", fontWeight: 600 }}>
          Save Changes
        </button>
      </form>
    </div>
  );
}
