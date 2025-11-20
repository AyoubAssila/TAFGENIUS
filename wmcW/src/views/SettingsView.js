import React, { useState } from 'react';

const modalStyles = {
  overlay: {
    position: "fixed",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 1000,
    padding: "20px"
  },
  content: {
    backgroundColor: "white",
    borderRadius: "16px",
    padding: "30px",
    maxWidth: "600px",
    width: "90%",
    maxHeight: "80vh",
    overflowY: "auto",
    boxShadow: "0 20px 25px -5px rgba(0, 0, 0, 0.1)",
    position: "relative"
  },
  closeButton: {
    position: "absolute",
    top: "15px",
    right: "15px",
    background: "none",
    border: "none",
    fontSize: "24px",
    cursor: "pointer",
    color: "#64748b",
    width: "30px",
    height: "30px",
    borderRadius: "50%",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    transition: "all 0.3s ease"
  },
  title: {
    fontSize: "24px",
    fontWeight: "bold",
    marginBottom: "20px",
    color: "#1e293b"
  },
  cancelButton: {
    backgroundColor: "#6b7280",
    color: "white",
    border: "none",
    padding: "10px 20px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease"
  },
  confirmButton: {
    backgroundColor: "#2563eb",
    color: "white",
    border: "none",
    padding: "10px 20px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease"
  }
};

const styles = {
  container: {
    width: "100%",
    padding: "30px"
  },
  contentSection: {
    backgroundColor: "white",
    borderRadius: "16px",
    padding: "25px",
    marginBottom: "30px",
    boxShadow: "0 4px 15px rgba(0,0,0,0.1)",
    border: "1px solid #e2e8f0",
    width: "100%"
  },
  sectionTitle: {
    fontSize: "20px",
    fontWeight: "bold",
    color: "#1e293b",
    marginBottom: "20px"
  },
  scheduleButton: {
    backgroundColor: "#3b82f6",
    color: "white",
    border: "none",
    padding: "12px 24px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease"
  },
  currentSettings: {
    backgroundColor: "#f8fafc",
    padding: "25px",
    borderRadius: "12px",
    border: "1px solid #e2e8f0",
    marginBottom: "30px"
  },
  settingsList: {
    display: "flex",
    flexDirection: "column",
    gap: "12px"
  },
  settingItem: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    padding: "12px 0",
    borderBottom: "1px solid #e5e7eb"
  },
  settingLabel: {
    fontWeight: "500",
    color: "#374151"
  },
  settingValue: {
    padding: "4px 12px",
    borderRadius: "6px",
    fontSize: "14px",
    fontWeight: "500"
  },
  valueEnabled: {
    backgroundColor: "#dcfce7",
    color: "#166534"
  },
  valueDisabled: {
    backgroundColor: "#fecaca",
    color: "#dc2626"
  },
  valueNeutral: {
    backgroundColor: "#e2e8f0",
    color: "#475569"
  },
  headerActions: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "25px"
  },
  settingsGroup: {
    marginBottom: "25px",
    paddingBottom: "15px",
    borderBottom: "1px solid #e5e7eb"
  },
  settingsTitle: {
    fontSize: "16px",
    fontWeight: "600",
    color: "#374151",
    marginBottom: "15px"
  },
  settingRow: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "12px",
    padding: "8px 0"
  },
  settingText: {
    display: "flex",
    alignItems: "center",
    gap: "10px",
    fontSize: "14px",
    color: "#374151"
  },
  checkbox: {
    width: "16px",
    height: "16px",
    cursor: "pointer"
  },
  select: {
    padding: "8px 12px",
    border: "1px solid #d1d5db",
    borderRadius: "6px",
    fontSize: "14px",
    minWidth: "120px",
    backgroundColor: "white",
    cursor: "pointer"
  },
  modalActions: {
    display: "flex",
    gap: "15px",
    justifyContent: "flex-end",
    marginTop: "25px"
  },
  dangerZone: {
    backgroundColor: "#fef2f2",
    padding: "20px",
    borderRadius: "12px",
    border: "1px solid #fecaca",
    marginTop: "30px"
  },
  dangerTitle: {
    color: "#dc2626",
    fontWeight: "600",
    marginBottom: "10px"
  },
  dangerButton: {
    backgroundColor: "#dc2626",
    color: "white",
    border: "none",
    padding: "8px 16px",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "500",
    transition: "all 0.3s ease"
  },
  infoBox: {
    backgroundColor: "#f0f9ff",
    padding: "20px",
    borderRadius: "12px",
    border: "1px solid #bae6fd",
    marginTop: "20px"
  }
};

// Composant Modal fonctionnel
const SettingsModal = ({ viewModel, onUpdate, onClose }) => {
  const [localSettings, setLocalSettings] = useState({ 
    ...viewModel.settings 
  });

  const handleSave = () => {
    // Mettre à jour les settings dans le viewModel
    if (viewModel.updateSettings) {
      viewModel.updateSettings(localSettings);
    } else {
      // Fallback si la méthode n'existe pas
      viewModel.settings = { ...localSettings };
    }
    onUpdate();
    onClose();
  };

  const handleReset = () => {
    const defaultSettings = {
      notifications: true,
      emailAlerts: true,
      darkMode: false,
      autoSave: true,
      language: "en",
      timezone: "UTC"
    };
    setLocalSettings(defaultSettings);
  };

  const handleInputChange = (field, value) => {
    setLocalSettings(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleDangerAction = (action) => {
    if (window.confirm(`Are you sure you want to ${action}? This action cannot be undone.`)) {
      alert(`${action} action triggered!`);
      // Ici vous implémenteriez la logique réelle
    }
  };

  return (
    <div style={modalStyles.overlay} onClick={onClose}>
      <div style={modalStyles.content} onClick={e => e.stopPropagation()}>
        <button 
          style={modalStyles.closeButton}
          onClick={onClose}
          onMouseEnter={(e) => e.target.style.backgroundColor = "#f3f4f6"}
          onMouseLeave={(e) => e.target.style.backgroundColor = "transparent"}
        >
          ×
        </button>

        <h2 style={modalStyles.title}>Platform Settings</h2>

        {/* Notifications */}
        <div style={styles.settingsGroup}>
          <h4 style={styles.settingsTitle}>Notifications</h4>
          <div style={styles.settingRow}>
            <label style={styles.settingText}>
              <input
                type="checkbox"
                checked={localSettings.notifications || false}
                onChange={(e) => handleInputChange('notifications', e.target.checked)}
                style={styles.checkbox}
              />
              Enable push notifications
            </label>
          </div>
          <div style={styles.settingRow}>
            <label style={styles.settingText}>
              <input
                type="checkbox"
                checked={localSettings.emailAlerts || false}
                onChange={(e) => handleInputChange('emailAlerts', e.target.checked)}
                style={styles.checkbox}
              />
              Email alerts for important updates
            </label>
          </div>
        </div>

        {/* Appearance */}
        <div style={styles.settingsGroup}>
          <h4 style={styles.settingsTitle}>Appearance</h4>
          <div style={styles.settingRow}>
            <label style={styles.settingText}>
              <input
                type="checkbox"
                checked={localSettings.darkMode || false}
                onChange={(e) => handleInputChange('darkMode', e.target.checked)}
                style={styles.checkbox}
              />
              Dark mode
            </label>
          </div>
        </div>

        {/* Preferences */}
        <div style={styles.settingsGroup}>
          <h4 style={styles.settingsTitle}>Preferences</h4>
          <div style={styles.settingRow}>
            <label style={styles.settingText}>
              <input
                type="checkbox"
                checked={localSettings.autoSave || false}
                onChange={(e) => handleInputChange('autoSave', e.target.checked)}
                style={styles.checkbox}
              />
              Auto-save changes
            </label>
          </div>
          <div style={styles.settingRow}>
            <label style={styles.settingText}>Language</label>
            <select 
              style={styles.select}
              value={localSettings.language || "en"}
              onChange={(e) => handleInputChange('language', e.target.value)}
            >
              <option value="en">English</option>
              <option value="fr">French</option>
              <option value="es">Spanish</option>
              <option value="ar">Arabic</option>
              <option value="de">German</option>
              <option value="it">Italian</option>
            </select>
          </div>
          <div style={styles.settingRow}>
            <label style={styles.settingText}>Timezone</label>
            <select 
              style={styles.select}
              value={localSettings.timezone || "UTC"}
              onChange={(e) => handleInputChange('timezone', e.target.value)}
            >
              <option value="UTC">UTC</option>
              <option value="EST">EST (Eastern)</option>
              <option value="PST">PST (Pacific)</option>
              <option value="CET">CET (Central Europe)</option>
              <option value="GMT">GMT (Greenwich)</option>
              <option value="IST">IST (India)</option>
            </select>
          </div>
        </div>

        {/* Danger Zone */}
        <div style={styles.dangerZone}>
          <h4 style={styles.dangerTitle}>Danger Zone</h4>
          <p style={{ color: "#dc2626", fontSize: "14px", marginBottom: "15px" }}>
            These actions are irreversible. Please proceed with caution.
          </p>
          <div style={{ display: "flex", gap: "10px" }}>
            <button 
              style={styles.dangerButton}
              onClick={() => handleDangerAction("clear all data")}
              onMouseEnter={(e) => e.target.style.opacity = "0.8"}
              onMouseLeave={(e) => e.target.style.opacity = "1"}
            >
              Clear All Data
            </button>
            <button 
              style={styles.dangerButton}
              onClick={() => handleDangerAction("delete account")}
              onMouseEnter={(e) => e.target.style.opacity = "0.8"}
              onMouseLeave={(e) => e.target.style.opacity = "1"}
            >
              Delete Account
            </button>
          </div>
        </div>

        <div style={styles.modalActions}>
          <button 
            style={modalStyles.cancelButton}
            onClick={handleReset}
            onMouseEnter={(e) => e.target.style.opacity = "0.8"}
            onMouseLeave={(e) => e.target.style.opacity = "1"}
          >
            Reset to Default
          </button>
          <button 
            style={modalStyles.confirmButton}
            onClick={handleSave}
            onMouseEnter={(e) => e.target.style.opacity = "0.8"}
            onMouseLeave={(e) => e.target.style.opacity = "1"}
          >
            Save Settings
          </button>
        </div>
      </div>
    </div>
  );
};

export const SettingsView = ({ viewModel, onUpdate }) => {
  const [showModal, setShowModal] = useState(false);

  // S'assurer que viewModel.settings existe
  const settings = viewModel.settings || {
    notifications: true,
    emailAlerts: true,
    darkMode: false,
    autoSave: true,
    language: "en",
    timezone: "UTC"
  };

  const getValueStyle = (value) => {
    if (typeof value === 'boolean') {
      return value ? styles.valueEnabled : styles.valueDisabled;
    }
    return styles.valueNeutral;
  };

  const getDisplayValue = (value) => {
    if (typeof value === 'boolean') {
      return value ? 'Enabled' : 'Disabled';
    }
    return value;
  };

  const handleOpenModal = () => {
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
  };

  return (
    <div style={styles.container}>
      <div style={styles.contentSection}>
        <div style={styles.headerActions}>
          <h3 style={styles.sectionTitle}>Platform Settings</h3>
          <button 
            style={styles.scheduleButton}
            onClick={handleOpenModal}
            onMouseEnter={(e) => e.target.style.transform = "scale(1.05)"}
            onMouseLeave={(e) => e.target.style.transform = "scale(1)"}
          >
            Configure Settings
          </button>
        </div>

        <div style={styles.currentSettings}>
          <h4 style={{ marginBottom: "20px", color: "#374151", fontSize: "18px" }}>Current Settings</h4>
          <div style={styles.settingsList}>
            {Object.entries(settings).map(([key, value]) => (
              <div key={key} style={styles.settingItem}>
                <span style={styles.settingLabel}>
                  {key.split(/(?=[A-Z])/).map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ')}
                </span>
                <span style={{...styles.settingValue, ...getValueStyle(value)}}>
                  {getDisplayValue(value)}
                </span>
              </div>
            ))}
          </div>
        </div>

        <div style={styles.infoBox}>
          <h4 style={{ color: "#0369a1", marginBottom: "10px" }}>Settings Information</h4>
          <p style={{ color: "#64748b", fontSize: "14px", lineHeight: "1.6" }}>
            Configure your platform preferences to customize your experience. 
            Changes are applied immediately and affect how you interact with the system.
          </p>
        </div>

        {showModal && (
          <SettingsModal 
            viewModel={viewModel} 
            onUpdate={onUpdate}
            onClose={handleCloseModal}
          />
        )}
      </div>
    </div>
  );
};