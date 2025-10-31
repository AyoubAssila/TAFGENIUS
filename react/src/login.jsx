import React, { useState } from 'react';
import { Form, Button, Card, Container } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    // Ici tu peux ajouter la logique de connexion
    alert('Connexion réussie !');
  };

  return (
    <div
      style={{
        minHeight: '100vh',
        background: 'linear-gradient(to bottom right, #c084fc, #60a5fa)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <Container style={{ maxWidth: '400px' }}>
        <Card className="p-4 shadow-lg rounded-4">
          <h2 className="text-center mb-4 text-primary">Connexion</h2>
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3" controlId="formEmail">
              <Form.Label>Email</Form.Label>
              <Form.Control
                type="email"
                placeholder="Entrez votre email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
            </Form.Group>

            <Form.Group className="mb-3" controlId="formPassword">
              <Form.Label>Mot de passe</Form.Label>
              <Form.Control
                type="password"
                placeholder="Entrez votre mot de passe"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </Form.Group>

            <Button
              type="submit"
              className="w-100 mb-3"
              style={{ backgroundColor: '#1e40af', border: 'none' }}
            >
              Se connecter
            </Button>

            <div className="text-center">
              <Button
                variant="link"
                onClick={() => navigate('/signup')}
              >
                Pas encore de compte ? Inscrivez-vous
              </Button>
            </div>
          </Form>
        </Card>
      </Container>
    </div>
  );
};

export default Login;
