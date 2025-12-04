// src/View/Pages/LoginPage.jsx
import React, { useState } from 'react';
import { Form, Button, Card, Container } from 'react-bootstrap';
import logo2 from '../../assets/logo2.png';
import useLoginViewModel from '../../viewmodel/login_viewmodel';

export default function LoginPage() {
  const [hovered, setHovered] = useState(false);
  const { user, setEmail, setPassword, login, goToSignUp } = useLoginViewModel();

  const labelStyle = { color: 'white', marginBottom: '5px', display: 'flex', alignItems: 'center' };
  const requiredStar = <span style={{ color: 'red', marginRight: '5px' }}>*</span>;
  const inputStyle = { color: '#000', backgroundColor: 'white', border: '1px solid #ccc' };

  return (
    <div style={{ minHeight: '100vh', backgroundColor: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <style>{`
        .login-card {
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
        .login-card.collapsed { height: 140px; }
        .login-card.expanded { height: 500px; }

        .login-header { display: flex; flex-direction: column; align-items: center; gap: 10px; }
        .login-header img { height: 60px; transition: transform 0.3s ease; }
        .login-header h2 { margin: 0; font-size: 24px; color: white; transition: all 0.3s ease; }
        .login-header:hover img { transform: scale(1.05); }
        .login-header:hover h2 { font-size: 28px; }

        .form-fields { opacity: 0; max-height: 0; overflow: hidden; transition: all 0.6s ease; width: 100%; margin-top: 0; }
        .form-fields.show { opacity: 1; max-height: 500px; margin-top: 20px; }
        .form-fields .mb-3 { opacity: 0; transform: translateY(-10px); transition: all 0.5s ease; }
        .form-fields.show .mb-3:nth-child(1) { transition-delay: 0.1s; opacity: 1; transform: translateY(0); }
        .form-fields.show .mb-3:nth-child(2) { transition-delay: 0.2s; opacity: 1; transform: translateY(0); }

        .login-btn {
          background-color: #06112aff;
          border: none;
          padding: 10px 0;
          font-size: 16px;
          font-weight: 600;
          transition: all 0.3s ease;
          width: 100%;
          margin-top: 20px;
        }
        .login-btn:hover {
          transform: scale(1.05);
          background-color: #141f30b9;
        }
      `}</style>

      <Container style={{ maxWidth: '400px' }}>
        <Card
          className={`shadow-lg login-card ${hovered ? 'expanded' : 'collapsed'}`}
          onMouseEnter={() => setHovered(true)}
          onMouseLeave={() => setHovered(false)}
        >
          <div className="login-header">
            <img src={logo2} alt="Logo" />
            <h2>Welcome Back!</h2>
          </div>

          <Form className={`form-fields ${hovered ? 'show' : ''}`}>
            <Form.Group className="mb-3" controlId="formEmail">
              <Form.Label style={labelStyle}>{requiredStar} Email</Form.Label>
              <Form.Control
                type="email"
                placeholder="Enter your email"
                value={user.email}
                onChange={(e) => setEmail(e.target.value)}
                required
                style={inputStyle}
              />
            </Form.Group>

            <Form.Group className="mb-3" controlId="formPassword">
              <Form.Label style={labelStyle}>{requiredStar} Password</Form.Label>
              <Form.Control
                type="password"
                placeholder="Enter your password"
                value={user.password}
                onChange={(e) => setPassword(e.target.value)}
                required
                style={inputStyle}
              />
            </Form.Group>

            <Button className="login-btn" onClick={login}>
              Log In
            </Button>

            <div className="text-center mt-2">
              <Button variant="link" onClick={goToSignUp} style={{ color: 'white' }}>
                Don't have an account? Sign Up
              </Button>
            </div>
          </Form>
        </Card>
      </Container>
    </div>
  );
}
