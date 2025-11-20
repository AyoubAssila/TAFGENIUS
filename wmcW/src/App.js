import React, { useState } from 'react';
import { LandingPage, DashboardView } from './views';

const App = () => {
  const [currentPage, setCurrentPage] = useState('home');

  return (
    <div>
      {currentPage === 'home' ? (
        <LandingPage onNavigateToDashboard={() => setCurrentPage('dashboard')} />
      ) : (
        <DashboardView onNavigateToHome={() => setCurrentPage('home')} />
      )}
    </div>
  );
};

export default App;