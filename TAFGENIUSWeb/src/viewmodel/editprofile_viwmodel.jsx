// src/ViewModel/editprofile_viewmodel.jsx
import { useState } from "react";
import UserModel from "../model/user_model"; // <-- import par défaut, pas d'accolades

export function useEditProfileViewModel() {
  const [user, setUser] = useState(new UserModel());
  const [confirmPassword, setConfirmPassword] = useState("");
  const [message, setMessage] = useState("");

  const setUsername = (username) => {
    const updatedUser = new UserModel(username, user.password);
    updatedUser.email = user.email; // conserver email
    setUser(updatedUser);
  };

  const setEmail = (email) => {
    const updatedUser = new UserModel(user.username || "", user.password);
    updatedUser.email = email;
    setUser(updatedUser);
  };

  const setPassword = (password) => {
    const updatedUser = new UserModel(user.username || "", password);
    updatedUser.email = user.email;
    setUser(updatedUser);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!user.validate()) {
      setMessage("Error: invalid email or password (min 6 chars)");
      return;
    }
    if (user.password !== confirmPassword) {
      setMessage("Error: passwords do not match");
      return;
    }
    setMessage("Profile updated successfully!");
    // Ici tu peux appeler ton API ou mettre à jour localStorage
  };

  return {
    username: user.username || "",
    setUsername,
    email: user.email || "",
    setEmail,
    password: user.password || "",
    setPassword,
    confirmPassword,
    setConfirmPassword,
    message,
    handleSubmit
  };
}
