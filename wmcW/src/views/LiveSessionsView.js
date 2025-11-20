import React from 'react';
import { NewLiveModal } from '../components/Modals';

const styles = {
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
  startLiveButton: {
    backgroundColor: "#ef4444",
    color: "white",
    border: "none",
    padding: "12px 24px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease"
  },
  scheduleButton: {
    backgroundColor: "#3b82f6",
    color: "white",
    border: "none",
    padding: "10px 20px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease",
    flex: 1
  },
  joinButton: {
    backgroundColor: "#22c55e",
    color: "white",
    border: "none",
    padding: "10px 20px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease",
    flex: 1
  },
  modifyButton: {
    backgroundColor: "#6b7280",
    color: "white",
    border: "none",
    padding: "10px 20px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease",
    flex: 1
  },
  liveSessions: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fill, minmax(380px, 1fr))",
    gap: "20px"
  },
  liveCard: {
    border: "2px solid #e2e8f0",
    borderRadius: "12px",
    padding: "20px",
    transition: "all 0.3s ease",
    position: "relative",
    backgroundColor: "#fafafa"
  },
  liveCardHover: {
    transform: "translateY(-2px)",
    boxShadow: "0 8px 25px rgba(0,0,0,0.1)"
  },
  liveCardActive: {
    borderColor: "#ef4444",
    backgroundColor: "#fef2f2"
  },
  liveBadge: {
    position: "absolute",
    top: "-10px",
    right: "20px",
    backgroundColor: "#ef4444",
    color: "white",
    padding: "5px 15px",
    borderRadius: "20px",
    fontSize: "12px",
    fontWeight: "bold",
    animation: "pulse 2s infinite"
  },
  liveTitle: {
    fontWeight: "600",
    fontSize: "18px",
    color: "#1e293b",
    marginBottom: "10px",
    paddingRight: "60px"
  },
  liveSchedule: {
    color: "#64748b",
    fontSize: "14px",
    marginBottom: "8px"
  },
  liveDescription: {
    color: "#64748b",
    fontSize: "14px",
    marginBottom: "15px",
    lineHeight: "1.4"
  },
  liveActions: {
    display: "flex",
    gap: "10px",
    marginTop: "15px"
  },
  headerActions: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "25px"
  },
  statsInfo: {
    color: "#64748b",
    fontSize: "14px",
    backgroundColor: "#f8fafc",
    padding: "8px 16px",
    borderRadius: "8px",
    border: "1px solid #e2e8f0"
  },
  emptyState: {
    textAlign: "center",
    padding: "60px 20px",
    color: "#64748b",
    backgroundColor: "#f8fafc",
    borderRadius: "12px",
    border: "2px dashed #e2e8f0",
    gridColumn: "1 / -1"
  },
  statusIndicator: {
    display: "inline-flex",
    alignItems: "center",
    gap: "6px",
    padding: "4px 8px",
    borderRadius: "12px",
    fontSize: "12px",
    fontWeight: "600"
  },
  statusLive: {
    backgroundColor: "#fef2f2",
    color: "#dc2626"
  },
  statusUpcoming: {
    backgroundColor: "#f0f9ff",
    color: "#0369a1"
  },
  participants: {
    display: "flex",
    alignItems: "center",
    gap: "8px",
    backgroundColor: "#f8fafc",
    padding: "4px 8px",
    borderRadius: "6px",
    fontSize: "12px",
    color: "#64748b"
  },
  // Styles pour le modal de modification
  modalOverlay: {
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
  modalContent: {
    backgroundColor: "white",
    borderRadius: "16px",
    padding: "30px",
    maxWidth: "500px",
    width: "90%",
    maxHeight: "80vh",
    overflowY: "auto",
    boxShadow: "0 20px 25px -5px rgba(0, 0, 0, 0.1)",
    position: "relative"
  },
  modalTitle: {
    fontSize: "24px",
    fontWeight: "bold",
    color: "#1e293b",
    marginBottom: "20px",
    paddingRight: "40px"
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
  inputGroup: {
    marginBottom: "20px"
  },
  label: {
    display: "block",
    marginBottom: "8px",
    fontWeight: "600",
    color: "#374151"
  },
  input: {
    width: "100%",
    padding: "12px 16px",
    border: "2px solid #d1d5db",
    borderRadius: "8px",
    fontSize: "16px",
    transition: "all 0.3s ease",
    fontFamily: "Arial, sans-serif"
  },
  textarea: {
    width: "100%",
    padding: "12px 16px",
    border: "2px solid #d1d5db",
    borderRadius: "8px",
    fontSize: "16px",
    minHeight: "100px",
    resize: "vertical",
    fontFamily: "Arial, sans-serif"
  },
  modalActions: {
    display: "flex",
    gap: "15px",
    justifyContent: "flex-end",
    marginTop: "25px"
  },
  cancelButton: {
    backgroundColor: "#6b7280",
    color: "white",
    border: "none",
    padding: "12px 24px",
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
    padding: "12px 24px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    fontWeight: "600",
    transition: "all 0.3s ease"
  },
  // Container principal
  container: {
    width: "100%",
    padding: "30px"
  }
};

// Composant modal pour modifier une session
const ModifySessionModal = ({ session, onClose, onUpdate }) => {
  const [title, setTitle] = React.useState(session?.title || '');
  const [schedule, setSchedule] = React.useState(session?.schedule || '');
  const [description, setDescription] = React.useState(session?.description || '');
  const [meetLink, setMeetLink] = React.useState(session?.meetLink || '');

  const handleSave = () => {
    if (session) {
      // Mettre à jour la session existante
      session.title = title;
      session.schedule = schedule;
      session.description = description;
      session.meetLink = meetLink;
      onUpdate();
    }
    onClose();
  };

  const handleJoinMeeting = () => {
    if (session?.meetLink) {
      window.open(session.meetLink, '_blank');
    }
  };

  return (
    <div style={styles.modalOverlay} onClick={onClose}>
      <div style={styles.modalContent} onClick={e => e.stopPropagation()}>
        <button 
          style={styles.closeButton}
          onClick={onClose}
          onMouseEnter={(e) => e.target.style.backgroundColor = "#f3f4f6"}
          onMouseLeave={(e) => e.target.style.backgroundColor = "transparent"}
        >
          ×
        </button>

        <h2 style={styles.modalTitle}>Modify Session</h2>
        
        <div style={styles.inputGroup}>
          <label style={styles.label}>Session Title</label>
          <input
            style={styles.input}
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Enter session title"
          />
        </div>

        <div style={styles.inputGroup}>
          <label style={styles.label}>Schedule</label>
          <input
            style={styles.input}
            type="text"
            value={schedule}
            onChange={(e) => setSchedule(e.target.value)}
            placeholder="e.g., January 20, 2024 - 14:00"
          />
        </div>

        <div style={styles.inputGroup}>
          <label style={styles.label}>Meet Link</label>
          <input
            style={styles.input}
            type="url"
            value={meetLink}
            onChange={(e) => setMeetLink(e.target.value)}
            placeholder="https://meet.google.com/xxx-xxxx-xxx"
          />
        </div>

        <div style={styles.inputGroup}>
          <label style={styles.label}>Description</label>
          <textarea
            style={styles.textarea}
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Enter session description"
            rows="4"
          />
        </div>

        {session?.meetLink && (
          <div style={{ marginBottom: "20px", padding: "15px", backgroundColor: "#f0f9ff", borderRadius: "8px", border: "1px solid #bae6fd" }}>
            <h4 style={{ color: "#0369a1", marginBottom: "10px" }}>Meeting Link Available</h4>
            <p style={{ color: "#64748b", fontSize: "14px", marginBottom: "10px" }}>
              Participants can join using this link:
            </p>
            <button 
              style={styles.joinButton}
              onClick={handleJoinMeeting}
            >
              Join Meeting
            </button>
          </div>
        )}

        <div style={styles.modalActions}>
          <button 
            style={styles.cancelButton}
            onClick={onClose}
          >
            Cancel
          </button>
          <button 
            style={styles.confirmButton}
            onClick={handleSave}
            disabled={!title.trim()}
          >
            Save Changes
          </button>
        </div>
      </div>
    </div>
  );
};

export const LiveSessionsView = ({ viewModel, onUpdate }) => {
  const [localHovered, setLocalHovered] = React.useState(null);
  const [showModal, setShowModal] = React.useState(false);
  const [modifyModalOpen, setModifyModalOpen] = React.useState(false);
  const [selectedSession, setSelectedSession] = React.useState(null);

  // Synchroniser avec le viewModel
  React.useEffect(() => {
    if (viewModel.showNewLiveModal !== showModal) {
      setShowModal(viewModel.showNewLiveModal);
    }
  }, [viewModel.showNewLiveModal]);

  const handleShowModal = () => {
    viewModel.updateNewLive('title', '');
    viewModel.updateNewLive('datetime', '');
    viewModel.updateNewLive('description', '');
    
    viewModel.setShowNewLiveModal(true);
    setShowModal(true);
    onUpdate();
  };

  const handleCloseModal = () => {
    viewModel.setShowNewLiveModal(false);
    setShowModal(false);
    onUpdate();
  };

  const handleStartLive = (sessionId) => {
    viewModel.startLiveSession(sessionId);
    onUpdate();
  };

  const handleModifySession = (session) => {
    setSelectedSession(session);
    setModifyModalOpen(true);
  };

  const handleCloseModifyModal = () => {
    setModifyModalOpen(false);
    setSelectedSession(null);
  };

  const handleJoinMeeting = (session) => {
    if (session.meetLink) {
      window.open(session.meetLink, '_blank');
    } else {
      alert('No meeting link available for this session');
    }
  };

  const getSessionStatus = (session) => {
    if (session.isActive) return { text: 'Live Now', style: styles.statusLive };
    const sessionTime = new Date(session.schedule);
    const now = new Date();
    if (sessionTime > now) return { text: 'Upcoming', style: styles.statusUpcoming };
    return { text: 'Completed', style: { backgroundColor: '#f3f4f6', color: '#6b7280' } };
  };

  // Ajouter des liens de meeting aux sessions existantes
  const sessionsWithMeetLinks = viewModel.liveSessions.map((session, index) => ({
    ...session,
    meetLink: session.meetLink || `https://meet.google.com/${['abc', 'def', 'ghi'][index % 3]}-${['xyz', 'uvw', 'rst'][index % 3]}-${['123', '456', '789'][index % 3]}`
  }));

  return (
    <div style={styles.container}>
      <div style={styles.contentSection}>
        <div style={styles.headerActions}>
          <h3 style={styles.sectionTitle}>Live Sessions</h3>
          <div style={{ display: "flex", alignItems: "center", gap: "15px" }}>
            <div style={styles.statsInfo}>
              {viewModel.liveSessions.length} sessions • {' '}
              {viewModel.liveSessions.filter(s => s.isActive).length} live • {' '}
              {viewModel.liveSessions.filter(s => !s.isActive && new Date(s.schedule) > new Date()).length} upcoming
            </div>
            <button 
              style={styles.startLiveButton}
              onClick={handleShowModal}
              onMouseEnter={(e) => e.target.style.transform = "scale(1.05)"}
              onMouseLeave={(e) => e.target.style.transform = "scale(1)"}
            >
              New Live Session
            </button>
          </div>
        </div>
        
        {viewModel.liveSessions.length === 0 ? (
          <div style={styles.emptyState}>
            <h3 style={{ color: "#374151", marginBottom: "10px" }}>No Live Sessions Scheduled</h3>
            <p style={{ marginBottom: "20px" }}>Schedule your first live session to engage with students</p>
            <button 
              style={styles.startLiveButton}
              onClick={handleShowModal}
            >
              Schedule First Session
            </button>
          </div>
        ) : (
          <div style={styles.liveSessions}>
            {sessionsWithMeetLinks.map(session => {
              const status = getSessionStatus(session);
              const isUpcoming = new Date(session.schedule) > new Date();
              const isCompleted = !session.isActive && new Date(session.schedule) <= new Date();
              
              return (
                <div 
                  key={session.id}
                  style={{
                    ...styles.liveCard,
                    ...(session.isActive ? styles.liveCardActive : {}),
                    ...(localHovered === `live-${session.id}` ? styles.liveCardHover : {})
                  }}
                  onMouseEnter={() => setLocalHovered(`live-${session.id}`)}
                  onMouseLeave={() => setLocalHovered(null)}
                >
                  {session.isActive && <div style={styles.liveBadge}>LIVE</div>}
                  
                  <div style={styles.liveTitle}>{session.title}</div>
                  
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "10px" }}>
                    <span style={{ ...styles.statusIndicator, ...status.style }}>
                      {status.text}
                    </span>
                    <div style={styles.participants}>
                      {session.participants} participants
                    </div>
                  </div>
                  
                  <div style={styles.liveSchedule}>
                    {session.schedule}
                  </div>
                  
                  <div style={styles.liveDescription}>
                    {session.description || "Join us for an interactive learning session!"}
                  </div>
                  
                  <div style={styles.liveActions}>
                    {session.isActive ? (
                      <>
                        <button 
                          style={styles.startLiveButton}
                          onClick={() => handleStartLive(session.id)}
                        >
                          Manage Live
                        </button>
                        <button 
                          style={styles.joinButton}
                          onClick={() => handleJoinMeeting(session)}
                        >
                          Participer
                        </button>
                      </>
                    ) : isUpcoming ? (
                      <>
                        <button 
                          style={styles.modifyButton}
                          onClick={() => handleModifySession(session)}
                        >
                          Modify
                        </button>
                        <button 
                          style={styles.joinButton}
                          onClick={() => handleJoinMeeting(session)}
                        >
                          Participer
                        </button>
                      </>
                    ) : (
                      <>
                        <button 
                          style={styles.modifyButton}
                          onClick={() => handleModifySession(session)}
                        >
                          View Details
                        </button>
                        <button 
                          style={styles.joinButton}
                          onClick={() => handleJoinMeeting(session)}
                        >
                          Recording
                        </button>
                      </>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {/* Modal pour créer une nouvelle session */}
        {(showModal || viewModel.showNewLiveModal) && (
          <NewLiveModal 
            viewModel={viewModel} 
            onUpdate={onUpdate}
            onClose={handleCloseModal}
          />
        )}

        {/* Modal pour modifier une session existante */}
        {modifyModalOpen && selectedSession && (
          <ModifySessionModal 
            session={selectedSession}
            onClose={handleCloseModifyModal}
            onUpdate={onUpdate}
          />
        )}

        <style>
          {`
            @keyframes pulse {
              0% { opacity: 1; }
              50% { opacity: 0.7; }
              100% { opacity: 1; }
            }
          `}
        </style>
      </div>
    </div>
  );
};