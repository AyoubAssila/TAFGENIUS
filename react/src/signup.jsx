import React, { useState } from 'react';
import { Form, Button, Card, Container } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';

const Signup = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if(password !== confirmPassword){
      alert('Les mots de passe ne correspondent pas !');
      return;
    }
    // Ici tu peux ajouter la logique d'inscription
    alert('Inscription réussie !');
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
          <h2 className="text-center mb-4 text-primary">
            Inscription
          </h2>
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3" controlId="formName">
              <Form.Label>Nom complet</Form.Label>
              <Form.Control
                type="text"
                placeholder="Entrez votre nom"
                value={name}
                onChange={(e) => setName(e.target.value)}
                required
              />
            </Form.Group>

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

            <Form.Group className="mb-3" controlId="formConfirmPassword">
              <Form.Label>Confirmer le mot de passe</Form.Label>
              <Form.Control
                type="password"
                placeholder="Confirmez votre mot de passe"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                required
              />
            </Form.Group>

            <Button
              type="submit"
              className="w-100 mb-3"
              style={{ backgroundColor: '#1e40af', border: 'none' }}
            >
              S’inscrire
            </Button>

            <div className="text-center">
              <Button
                variant="link"
                onClick={() => navigate('/login')}
              >
                Vous avez déjà un compte ? Connectez-vous
              </Button>
            </div>
          </Form>
        </Card>
      </Container>
    </div>
  );
};

export default Signup;



