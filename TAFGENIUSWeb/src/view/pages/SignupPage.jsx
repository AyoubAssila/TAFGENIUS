// src/View/Pages/SignupPage.jsx
import React, { useState } from "react";
import { Form, Button, Card, Container } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import logo2 from "../../assets/logo2.png";
import { useSignupViewModel } from "../../viewmodel/signup_viewmodel";

export default function SignupPage() {
  const [hovered, setHovered] = useState(false);
  const navigate = useNavigate();
  const { name, setName, email, setEmail, password, setPassword, confirmPassword, setConfirmPassword, handleSignup } = useSignupViewModel();

  const labelStyle = { color: "white", display: "flex", alignItems: "center", marginBottom: "5px" };
  const requiredStar = <span style={{ color: "red", marginRight: "5px" }}>*</span>;
  const inputStyle = { color: "#000", backgroundColor: "white", border: "1px solid #ccc" };

  return (
    <div style={{ minHeight: "100vh", backgroundColor: "white", display: "flex", alignItems: "center", justifyContent: "center" }}>
      <style>{`
        .signup-card {
          background: linear-gradient(to bottom right, #c084fc, #60a5fa);
          width: 400px;
          transition: all 0.6s ease;
          overflow: hidden;
          cursor: pointer;
          border-radius: 1rem;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          padding: 20px;
        }
        .signup-card.collapsed { height: 140px; }
        .signup-card.expanded { height: 600px; }
        .signup-header { display: flex; flex-direction: column; align-items: center; gap: 10px; }
        .signup-header img { height: 60px; transition: transform 0.3s ease; }
        .signup-header h2 { margin: 0; font-size: 24px; color: white; transition: all 0.3s ease; }
        .signup-header:hover img { transform: scale(1.05); }
        .signup-header:hover h2 { font-size: 28px; }
        .form-fields { opacity: 0; max-height: 0; overflow: hidden; transition: all 0.6s ease; width: 100%; margin-top: 0; }
        .form-fields.show { opacity: 1; max-height: 500px; margin-top: 20px; }
        .form-fields .mb-3 { opacity: 0; transform: translateY(-10px); transition: all 0.5s ease; }
        .form-fields.show .mb-3:nth-child(1) { transition-delay: 0.1s; opacity: 1; transform: translateY(0); }
        .form-fields.show .mb-3:nth-child(2) { transition-delay: 0.2s; opacity: 1; transform: translateY(0); }
        .form-fields.show .mb-3:nth-child(3) { transition-delay: 0.3s; opacity: 1; transform: translateY(0); }
        .form-fields.show .mb-3:nth-child(4) { transition-delay: 0.4s; opacity: 1; transform: translateY(0); }
        .signup-btn {
          background-color: #06112aff;
          border: none;
          padding: 10px 0;
          font-size: 16px;
          font-weight: 600;
          transition: all 0.3s ease;
          width: 100%;
          margin-top: 20px;
        }
        .signup-btn:hover {
          transform: scale(1.05);
          background-color: #141f30b9;
        }
      `}</style>

      <Container style={{ maxWidth: "400px" }}>
        <Card className={`shadow-lg rounded-4 signup-card ${hovered ? "expanded" : "collapsed"}`} onMouseEnter={() => setHovered(true)} onMouseLeave={() => setHovered(false)}>
          <div className="signup-header">
            <img src={logo2} alt="Logo" />
            <h2>Become a Genius!</h2>
          </div>

          <Form onSubmit={(e) => { e.preventDefault(); handleSignup(); }} className={`form-fields ${hovered ? "show" : ""}`}>
            <Form.Group className="mb-3" controlId="formName">
              <Form.Label style={labelStyle}>{requiredStar} Full Name</Form.Label>
              <Form.Control type="text" placeholder="Enter your name" value={name} onChange={(e) => setName(e.target.value)} required style={inputStyle}/>
            </Form.Group>

            <Form.Group className="mb-3" controlId="formEmail">
              <Form.Label style={labelStyle}>{requiredStar} Email</Form.Label>
              <Form.Control type="email" placeholder="Enter your email" value={email} onChange={(e) => setEmail(e.target.value)} required style={inputStyle}/>
            </Form.Group>

            <Form.Group className="mb-3" controlId="formPassword">
              <Form.Label style={labelStyle}>{requiredStar} Password</Form.Label>
              <Form.Control type="password" placeholder="Enter your password" value={password} onChange={(e) => setPassword(e.target.value)} required style={inputStyle}/>
            </Form.Group>

            <Form.Group className="mb-3" controlId="formConfirmPassword">
              <Form.Label style={labelStyle}>{requiredStar} Confirm Password</Form.Label>
              <Form.Control type="password" placeholder="Confirm your password" value={confirmPassword} onChange={(e) => setConfirmPassword(e.target.value)} required style={inputStyle}/>
            </Form.Group>

            <Button type="submit" className="w-100 signup-btn">Sign Up</Button>

            <div className="text-center mt-2">
              <Button variant="link" onClick={() => navigate("/login")} style={{ color: "white" }}>Already have an account? Log in</Button>
            </div>
          </Form>
        </Card>
      </Container>
    </div>
  );
}
