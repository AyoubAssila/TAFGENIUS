// src/ViewModel/signup_viewmodel.jsx
import { useState } from "react";
import UserModel from "../model/user_model";
import { useNavigate } from "react-router-dom";

export function useSignupViewModel() {
  const [user, setUser] = useState(new UserModel());
  const [name, setName] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const navigate = useNavigate();

  const setEmail = (email) => {
    const updatedUser = new UserModel(user.email, user.password);
    updatedUser.email = email;
    setUser(updatedUser);
  };

  const setPassword = (password) => {
    const updatedUser = new UserModel(user.email, password);
    setUser(updatedUser);
  };

  const handleSignup = () => {
    if (!name || !user.email.includes("@") || user.password.length < 6) {
      alert("Please fill all fields correctly (password min 6 chars)");
      return;
    }
    if (user.password !== confirmPassword) {
      alert("Passwords do not match");
      return;
    }
    // Ici tu peux appeler ton API pour créer l'utilisateur
    alert(`Welcome ${name}! Your account has been created.`);
    navigate("/login");
  };

  return {
    name,
    setName,
    email: user.email,
    setEmail,
    password: user.password,
    setPassword,
    confirmPassword,
    setConfirmPassword,
    handleSignup
  };
}
