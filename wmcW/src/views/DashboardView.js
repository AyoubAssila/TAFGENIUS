import React from 'react';
import { DashboardViewModel } from '../viewmodels/DashboardViewModel';
import { Sidebar } from './Sidebar';
import { Header } from './Header';
import { DashboardContent } from './DashboardContent';
import { CoursesView } from './CoursesView';
import { MessagingView } from './MessagingView';
import { LiveSessionsView } from './LiveSessionsView';
import { AnalyticsView } from './AnalyticsView';
import { SettingsView } from './SettingsView';

const styles = {
  container: {
    minHeight: "100vh",
    backgroundColor: "#f8fafc",
    fontFamily: "Arial, sans-serif",
    display: "flex"
  },
  mainContent: {
    flex: 1,
    padding: "0",
    overflowY: "auto",
    marginLeft: "280px",
    backgroundColor: "#f8fafc",
    display: "flex",
    flexDirection: "column"
  },
  contentArea: {
    padding: "30px",
    minHeight: "calc(100vh - 100px)",
    backgroundColor: "#f8fafc",
    display: "flex",
    justifyContent: "center",
    alignItems: "flex-start"
  },
  centeredContent: {
    width: "100%",
    maxWidth: "1200px",
    display: "flex",
    flexDirection: "column",
    gap: "30px"
  },
  loadingContainer: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    height: "100vh",
    backgroundColor: "#f8fafc",
    marginLeft: "280px",
    flexDirection: "column",
    gap: "20px"
  },
  loadingText: {
    fontSize: "18px",
    color: "#64748b",
    fontWeight: "500"
  },
  spinner: {
    width: "40px",
    height: "40px",
    border: "4px solid #e2e8f0",
    borderTop: "4px solid #2563eb",
    borderRadius: "50%",
    animation: "spin 1s linear infinite"
  }
};

// Style pour l'animation de spinner
const spinnerStyle = `
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
`;

export const DashboardView = ({ onNavigateToHome }) => {
  const [viewModel] = React.useState(() => new DashboardViewModel());
  const [forceUpdate, setForceUpdate] = React.useState(0);
  const [isLoading, setIsLoading] = React.useState(true);

  // Initialisation des données
  React.useEffect(() => {
    const initializeData = async () => {
      try {
        // Simuler un chargement asynchrone
        await new Promise(resolve => setTimeout(resolve, 1000));
        viewModel.initializeMockData();
        setIsLoading(false);
        setForceUpdate(prev => prev + 1);
      } catch (error) {
        console.error('Error initializing data:', error);
        setIsLoading(false);
      }
    };

    initializeData();
  }, [viewModel]);

  const handleTabChange = (tab) => {
    viewModel.setActiveTab(tab);
    setForceUpdate(prev => prev + 1);
  };

  const handleUpdate = () => {
    setForceUpdate(prev => prev + 1);
  };

  const renderActiveTab = () => {
    if (isLoading) {
      return (
        <div style={styles.loadingContainer}>
          <style>{spinnerStyle}</style>
          <div style={styles.spinner}></div>
          <div style={styles.loadingText}>Loading Dashboard...</div>
        </div>
      );
    }

    const activeContent = (() => {
      switch (viewModel.activeTab) {
        case 'dashboard':
          return (
            <DashboardContent 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="dashboard-content"
            />
          );
        case 'courses':
          return (
            <CoursesView 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="courses-view"
            />
          );
        case 'messaging':
          return (
            <MessagingView 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="messaging-view"
            />
          );
        case 'live':
          return (
            <LiveSessionsView 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="live-sessions-view"
            />
          );
        case 'analytics':
          return (
            <AnalyticsView 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="analytics-view"
            />
          );
        case 'settings':
          return (
            <SettingsView 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="settings-view"
            />
          );
        default:
          return (
            <DashboardContent 
              viewModel={viewModel} 
              onUpdate={handleUpdate} 
              key="default-dashboard"
            />
          );
      }
    })();

    // Retourner le contenu centré
    return (
      <div style={styles.centeredContent}>
        {activeContent}
      </div>
    );
  };

  const handleNavigateHome = () => {
    if (onNavigateToHome) {
      onNavigateToHome();
    }
  };

  return (
    <div style={styles.container}>
      <Sidebar 
        activeTab={viewModel.activeTab}
        onTabChange={handleTabChange}
        onNavigateToHome={handleNavigateHome}
      />
      
      <div style={styles.mainContent}>
        <Header activeTab={viewModel.activeTab} />
        <div style={styles.contentArea}>
          {renderActiveTab()}
        </div>
      </div>
    </div>
  );
};

export default DashboardView;