import React from 'react';

const styles = {
  statsGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(250px, 1fr))",
    gap: "20px",
    marginBottom: "30px",
    width: "100%",
    padding: "0 30px"
  },
  statCard: {
    backgroundColor: "white",
    padding: "25px",
    borderRadius: "16px",
    boxShadow: "0 4px 15px rgba(0,0,0,0.1)",
    transition: "all 0.3s ease",
    border: "1px solid #e2e8f0",
    textAlign: "center"
  },
  statCardHover: {
    transform: "translateY(-5px)",
    boxShadow: "0 8px 25px rgba(0,0,0,0.15)",
    borderColor: "#2563eb"
  },
  statValue: {
    fontSize: "32px",
    fontWeight: "bold",
    color: "#1e293b",
    marginBottom: "8px"
  },
  statLabel: {
    color: "#64748b",
    fontSize: "16px",
    fontWeight: "600"
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
  messageItem: {
    border: "1px solid #e2e8f0",
    borderRadius: "12px",
    padding: "20px",
    marginBottom: "15px",
    transition: "all 0.3s ease",
    cursor: "pointer",
    backgroundColor: "#fafafa"
  },
  messageItemHover: {
    borderColor: "#2563eb",
    backgroundColor: "#f0f9ff",
    transform: "translateX(5px)"
  },
  messageHeader: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "flex-start",
    marginBottom: "10px"
  },
  messageUser: {
    fontWeight: "600",
    color: "#1e293b",
    fontSize: "16px",
    flex: 1
  },
  messageTime: {
    color: "#64748b",
    fontSize: "14px",
    minWidth: "80px",
    textAlign: "right"
  },
  messageContent: {
    color: "#64748b",
    fontSize: "14px",
    marginBottom: "10px",
    lineHeight: "1.4"
  },
  messageMeta: {
    display: "flex",
    gap: "15px",
    fontSize: "13px",
    color: "#94a3b8",
    marginBottom: "10px"
  },
  messageActions: {
    display: "flex",
    gap: "10px"
  },
  replyButton: {
    backgroundColor: "#2563eb",
    color: "white",
    border: "none",
    padding: "8px 16px",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "14px",
    transition: "all 0.3s ease",
    fontWeight: "500"
  },
  viewConversationButton: {
    backgroundColor: "#f3f4f6",
    color: "#374151",
    border: "none",
    padding: "6px 12px",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "12px",
    transition: "all 0.3s ease",
    fontWeight: "500"
  },
  liveCard: {
    border: "2px solid #e2e8f0",
    borderRadius: "12px",
    padding: "20px",
    marginBottom: "15px",
    transition: "all 0.3s ease",
    position: "relative",
    backgroundColor: "#fafafa"
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
    fontWeight: "bold"
  },
  liveTitle: {
    fontWeight: "600",
    fontSize: "18px",
    color: "#1e293b",
    marginBottom: "10px"
  },
  liveSchedule: {
    color: "#64748b",
    fontSize: "14px",
    marginBottom: "8px"
  },
  liveActions: {
    display: "flex",
    gap: "10px",
    marginTop: "15px"
  },
  startLiveButton: {
    backgroundColor: "#ef4444",
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
  analyticsGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(200px, 1fr))",
    gap: "15px",
    marginTop: "15px"
  },
  analyticsItem: {
    backgroundColor: "#f8fafc",
    padding: "15px",
    borderRadius: "8px",
    textAlign: "center",
    border: "1px solid #e2e8f0"
  },
  analyticsValue: {
    fontSize: "24px",
    fontWeight: "bold",
    color: "#2563eb",
    marginBottom: "5px"
  },
  analyticsLabel: {
    color: "#64748b",
    fontSize: "14px"
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

// Données mock pour les messages récents
const recentMessages = [
  {
    id: 1,
    user: {
      name: "Sarah Johnson",
      avatar: "SJ",
      course: "Machine Learning Basics"
    },
    content: "Thank you for clarifying the assignment requirements!",
    timestamp: new Date(Date.now() - 5 * 60 * 1000), // 5 minutes ago
    unread: false,
    conversationId: 1
  },
  {
    id: 2,
    user: {
      name: "Mike Wilson",
      avatar: "MW",
      course: "Advanced Web Development"
    },
    content: "When will the next project be assigned? I want to get started early.",
    timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000), // 2 hours ago
    unread: true,
    conversationId: 2
  },
  {
    id: 3,
    user: {
      name: "Emma Davis",
      avatar: "ED",
      course: "Data Analysis with R"
    },
    content: "The correlation analysis was very helpful for my research project.",
    timestamp: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000), // 1 day ago
    unread: false,
    conversationId: 3
  }
];

export const DashboardContent = ({ viewModel, onUpdate }) => {
  const [localHovered, setLocalHovered] = React.useState(null);
  const [modifyModalOpen, setModifyModalOpen] = React.useState(false);
  const [selectedSession, setSelectedSession] = React.useState(null);
  
  const stats = viewModel.getStats();

  const handleViewConversation = (conversationId) => {
    // Naviguer vers la messagerie avec la conversation sélectionnée
    viewModel.setActiveTab('messaging');
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

  const getTimeDisplay = (timestamp) => {
    const now = new Date();
    const messageTime = new Date(timestamp);
    const diffInHours = (now - messageTime) / (1000 * 60 * 60);
    
    if (diffInHours < 1) {
      const minutes = Math.floor(diffInHours * 60);
      return `${minutes}m ago`;
    } else if (diffInHours < 24) {
      return `${Math.floor(diffInHours)}h ago`;
    } else {
      return messageTime.toLocaleDateString();
    }
  };

  // Ajouter des liens de meeting aux sessions existantes
  const sessionsWithMeetLinks = viewModel.liveSessions.map((session, index) => ({
    ...session,
    meetLink: session.meetLink || `https://meet.google.com/${['abc', 'def', 'ghi'][index % 3]}-${['xyz', 'uvw', 'rst'][index % 3]}-${['123', '456', '789'][index % 3]}`
  }));

  return (
    <div style={styles.container}>
      {/* Stats Grid */}
      <div style={styles.statsGrid}>
        {[
          { value: stats.totalStudents, label: "Enrolled Students", id: 'stat1' },
          { value: stats.totalCourses, label: "Active Courses", id: 'stat2' },
          { value: stats.activeLiveSessions, label: "Live Sessions", id: 'stat3' },
          { value: recentMessages.length, label: "Recent Messages", id: 'stat4' }
        ].map(stat => (
          <div 
            key={stat.id}
            style={{
              ...styles.statCard,
              ...(localHovered === stat.id ? styles.statCardHover : {})
            }}
            onMouseEnter={() => setLocalHovered(stat.id)}
            onMouseLeave={() => setLocalHovered(null)}
          >
            <div style={styles.statValue}>{stat.value}</div>
            <div style={styles.statLabel}>{stat.label}</div>
          </div>
        ))}
      </div>

      {/* Recent Messages */}
      <div style={styles.contentSection}>
        <h3 style={styles.sectionTitle}>Recent Messages</h3>
        <div style={{ maxHeight: "400px", overflowY: "auto" }}>
          {recentMessages.map(message => (
            <div 
              key={message.id}
              style={{
                ...styles.messageItem,
                ...(localHovered === `message-${message.id}` ? styles.messageItemHover : {})
              }}
              onMouseEnter={() => setLocalHovered(`message-${message.id}`)}
              onMouseLeave={() => setLocalHovered(null)}
            >
              <div style={styles.messageHeader}>
                <div style={styles.messageUser}>{message.user.name}</div>
                <div style={styles.messageTime}>{getTimeDisplay(message.timestamp)}</div>
              </div>
              <div style={styles.messageContent}>{message.content}</div>
              <div style={styles.messageMeta}>
                <span>{message.user.course}</span>
                {message.unread && <span style={{color: "#ef4444"}}>New</span>}
              </div>
              <div style={styles.messageActions}>
                <button 
                  style={styles.replyButton}
                  onClick={() => handleViewConversation(message.conversationId)}
                >
                  Reply
                </button>
                <button 
                  style={styles.viewConversationButton}
                  onClick={() => handleViewConversation(message.conversationId)}
                >
                  View Conversation
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Upcoming Sessions */}
      <div style={styles.contentSection}>
        <h3 style={styles.sectionTitle}>Upcoming Sessions</h3>
        <div style={{ maxHeight: "400px", overflowY: "auto" }}>
          {sessionsWithMeetLinks.slice(0, 3).map(session => (
            <div 
              key={session.id}
              style={{
                ...styles.liveCard,
                ...(session.isActive ? styles.liveCardActive : {}),
                ...(localHovered === `live-${session.id}` ? { transform: "translateY(-2px)" } : {})
              }}
              onMouseEnter={() => setLocalHovered(`live-${session.id}`)}
              onMouseLeave={() => setLocalHovered(null)}
            >
              {session.isActive && <div style={styles.liveBadge}>LIVE NOW</div>}
              <div style={styles.liveTitle}>{session.title}</div>
              <div style={styles.liveSchedule}>
                {session.schedule}
              </div>
              <div style={styles.liveSchedule}>
                {session.participants} participants
              </div>
              <div style={styles.liveActions}>
                {session.isActive ? (
                  <>
                    <button 
                      style={styles.startLiveButton}
                      onClick={() => handleStartLive(session.id)}
                    >
                      Join Live
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
                      style={styles.scheduleButton}
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
                )}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Quick Analytics */}
      <div style={styles.contentSection}>
        <h3 style={styles.sectionTitle}>Quick Analytics</h3>
        <div style={styles.analyticsGrid}>
          <div style={styles.analyticsItem}>
            <div style={styles.analyticsValue}>68%</div>
            <div style={styles.analyticsLabel}>Course Completion</div>
          </div>
          <div style={styles.analyticsItem}>
            <div style={styles.analyticsValue}>82%</div>
            <div style={styles.analyticsLabel}>Student Engagement</div>
          </div>
          <div style={styles.analyticsItem}>
            <div style={styles.analyticsValue}>+15%</div>
            <div style={styles.analyticsLabel}>Message Activity</div>
          </div>
          <div style={styles.analyticsItem}>
            <div style={styles.analyticsValue}>94%</div>
            <div style={styles.analyticsLabel}>Satisfaction Rate</div>
          </div>
        </div>
      </div>

      {/* Modal de modification */}
      {modifyModalOpen && selectedSession && (
        <ModifySessionModal 
          session={selectedSession}
          onClose={handleCloseModifyModal}
          onUpdate={onUpdate}
        />
      )}
    </div>
  );
};