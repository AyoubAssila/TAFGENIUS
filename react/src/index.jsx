import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './assets/app.jsx';               // ← ton fichier App actuel
import 'bootstrap/dist/css/bootstrap.min.css'; // Bootstrap

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);