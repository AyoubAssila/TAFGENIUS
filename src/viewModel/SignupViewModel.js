// // src/viewmodels/SignupViewModel.js

// import { useState } from "react";
// import SignupModel from "../models/SignupModel";

// const useSignupViewModel = () => {
//   const model = new SignupModel();

//   const [name, setName] = useState("");
//   const [email, setEmail] = useState("");
//   const [password, setPassword] = useState("");
//   const [confirmPassword, setConfirmPassword] = useState("");

//   const [loading, setLoading] = useState(false);
//   const [error, setError] = useState("");

//   const signup = async () => {
//     setError("");

//     if (password !== confirmPassword) {
//       setError("Les mots de passe ne correspondent pas !");
//       return { success: false };
//     }

//     setLoading(true);

//     try {
//       const result = await model.signup(name, email, password);
//       setLoading(false);
//       return { success: true, message: result.message };
//     } catch (err) {
//       setLoading(false);
//       setError(err.message);
//       return { success: false };
//     }
//   };

//   return {
//     name,
//     email,
//     password,
//     confirmPassword,
//     loading,
//     error,
//     setName,
//     setEmail,
//     setPassword,
//     setConfirmPassword,
//     signup,
//   };
// };

// export default useSignupViewModel;
