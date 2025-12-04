// src/ViewModel/login_viewmodel.jsx
import { useState } from 'react';
import UserModel from '../model/user_model';
import { useNavigate } from 'react-router-dom';

export default function useLoginViewModel() {
  const [user, setUser] = useState(new UserModel());
  const navigate = useNavigate();

  const setEmail = (email) => {
    const updatedUser = new UserModel(email, user.password);
    setUser(updatedUser);
  };

  const setPassword = (password) => {
    const updatedUser = new UserModel(user.email, password);
    setUser(updatedUser);
  };

  const login = () => {
    if (user.validate()) {
      navigate('/etudiant');
    } else {
      alert('Please enter a valid email and password (min 6 characters)');
    }
  };

  const goToSignUp = () => navigate('/signup');

  return {
    user,
    setEmail,
    setPassword,
    login,
    goToSignUp
  };
}
