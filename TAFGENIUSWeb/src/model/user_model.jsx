// src/Model/user_model.jsx
export default class UserModel {
  constructor(email = '', password = '') {
    this.email = email;
    this.password = password;
  }

  setEmail(email) {
    this.email = email;
  }

  setPassword(password) {
    this.password = password;
  }

  validate() {
    const emailValid = this.email.includes('@');
    const passwordValid = this.password.length >= 6;
    return emailValid && passwordValid;
  }
}
