import React, { useState } from "react";
import logo2 from "../../assets/logo2.png";

export default function EditProfilePage() {
  const [hovered, setHovered] = useState(false);

  const [username, setUsername] = useState("JohnDoe");
  const [email, setEmail] = useState("johndoe@example.com");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [message, setMessage] = useState("");

  const labelStyle = { color: 'white', marginBottom: '5px', display: 'flex', alignItems: 'center' };
  const requiredStar = <span style={{ color: 'red', marginRight: '5px' }}>*</span>;
  const inputStyle = { color: '#000', backgroundColor: 'white', border: '1px solid #ccc' };

  const handleSubmit = (e) => {
    e.preventDefault();

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

    setMessage("Profile updated successfully!");
    console.log({ username, email, password });

    setPassword("");
    setConfirmPassword("");
  };

  return (
    <div
      style={{
        minHeight: "100vh",
        backgroundColor: "white",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      {/* SAME ANIMATION + STYLE AS LOGIN PAGE */}
      <style>{`
        .edit-card {
          background: linear-gradient(to bottom right, #c084fc, #60a5fa);
          width: 450px;
          transition: all 0.6s ease;
          overflow: hidden;
          cursor: pointer;
          border-radius: 1rem;
          padding: 20px;
        }
        .edit-card.collapsed { height: 160px; }
        .edit-card.expanded { height: 650px; }

        .edit-header {
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 10px;
        }
        .edit-header img {
          height: 60px;
          transition: transform 0.3s ease;
        }
        .edit-header h2 {
          margin: 0;
          font-size: 24px;
          color: white;
          transition: all 0.3s ease;
        }
        .edit-header:hover img { transform: scale(1.05); }
        .edit-header:hover h2 { font-size: 28px; }

        .form-fields {
          opacity: 0;
          max-height: 0;
          overflow: hidden;
          transition: all 0.6s ease;
          width: 100%;
        }
        .form-fields.show {
          opacity: 1;
          max-height: 800px;
          margin-top: 20px;
        }

        .form-fields .field {
          opacity: 0;
          transform: translateY(-10px);
          transition: all 0.5s ease;
        }

        .form-fields.show .field:nth-child(1) { transition-delay: 0.1s; opacity: 1; transform: translateY(0); }
        .form-fields.show .field:nth-child(2) { transition-delay: 0.2s; opacity: 1; transform: translateY(0); }
        .form-fields.show .field:nth-child(3) { transition-delay: 0.3s; opacity: 1; transform: translateY(0); }
        .form-fields.show .field:nth-child(4) { transition-delay: 0.4s; opacity: 1; transform: translateY(0); }

        .save-btn {
          background-color: #06112aff;
          border: none;
          padding: 12px 0;
          font-size: 16px;
          font-weight: 600;
          transition: all 0.3s ease;
          width: 100%;
          margin-top: 20px;
          color: white;
        }
        .save-btn:hover {
          transform: scale(1.05);
          background-color: #141f30b9;
        }

        .message-box {
          margin-bottom: 15px;
          padding: 10px;
          border-radius: 5px;
        }
      `}</style>

      <div
        className={`shadow-lg edit-card ${hovered ? "expanded" : "collapsed"}`}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        {/* HEADER */}
        <div className="edit-header">
          <img src={logo2} alt="Logo" />
          <h2>Edit Profile</h2>
        </div>

        {/* MESSAGE */}
        {message && (
          <div
            className="message-box"
            style={{
              background: message.includes("success") ? "#d4edda" : "#f8d7da",
              color: message.includes("success") ? "#155724" : "#721c24",
            }}
          >
            {message}
          </div>
        )}

        {/* FORM */}
        <form className={`form-fields ${hovered ? "show" : ""}`} onSubmit={handleSubmit}>

          <div className="field" style={{ marginBottom: 15 }}>
            <label style={labelStyle}>{requiredStar} Username</label>
            <input
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              style={{ ...inputStyle, width: "100%", padding: 10, borderRadius: 5 }}
            />
          </div>

          <div className="field" style={{ marginBottom: 15 }}>
            <label style={labelStyle}>{requiredStar} Email</label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              style={{ ...inputStyle, width: "100%", padding: 10, borderRadius: 5 }}
            />
          </div>

          <div className="field" style={{ marginBottom: 15 }}>
            <label style={labelStyle}>{requiredStar} New Password</label>
            <input
              type="password"
              value={password}
              placeholder="Enter new password"
              onChange={(e) => setPassword(e.target.value)}
              style={{ ...inputStyle, width: "100%", padding: 10, borderRadius: 5 }}
            />
          </div>

          <div className="field" style={{ marginBottom: 20 }}>
            <label style={labelStyle}>{requiredStar} Confirm Password</label>
            <input
              type="password"
              value={confirmPassword}
              placeholder="Confirm password"
              onChange={(e) => setConfirmPassword(e.target.value)}
              style={{ ...inputStyle, width: "100%", padding: 10, borderRadius: 5 }}
            />
          </div>

          <button type="submit" className="save-btn">
            Save Changes
          </button>
        </form>
      </div>
    </div>
  );
}
