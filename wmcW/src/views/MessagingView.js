import React from 'react';

const styles = {
  container: {
    width: "100%",
    padding: "30px",
    height: "calc(100vh - 100px)",
    display: "flex",
    gap: "20px"
  },
  contentSection: {
    backgroundColor: "white",
    borderRadius: "16px",
    padding: "25px",
    boxShadow: "0 4px 15px rgba(0,0,0,0.1)",
    border: "1px solid #e2e8f0",
    flex: 1,
    display: "flex",
    flexDirection: "column"
  },
  sectionTitle: {
    fontSize: "20px",
    fontWeight: "bold",
    color: "#1e293b",
    marginBottom: "20px"
  },
  messagingContainer: {
    display: "flex",
    flex: 1,
    gap: "20px",
    height: "600px"
  },
  conversationsList: {
    width: "300px",
    border: "1px solid #e2e8f0",
    borderRadius: "12px",
    overflow: "hidden",
    display: "flex",
    flexDirection: "column"
  },
  conversationHeader: {
    padding: "20px",
    borderBottom: "1px solid #e2e8f0",
    backgroundColor: "#f8fafc"
  },
  searchInput: {
    width: "100%",
    padding: "10px 15px",
    border: "1px solid #d1d5db",
    borderRadius: "8px",
    fontSize: "14px"
  },
  conversations: {
    flex: 1,
    overflowY: "auto"
  },
  conversationItem: {
    padding: "15px 20px",
    borderBottom: "1px solid #e2e8f0",
    cursor: "pointer",
    transition: "all 0.3s ease",
    display: "flex",
    alignItems: "center",
    gap: "12px"
  },
  conversationItemActive: {
    backgroundColor: "#2563eb",
    color: "white"
  },
  conversationItemHover: {
    backgroundColor: "#f3f4f6"
  },
  avatar: {
    width: "40px",
    height: "40px",
    borderRadius: "50%",
    backgroundColor: "#2563eb",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    color: "white",
    fontWeight: "bold",
    fontSize: "16px"
  },
  conversationInfo: {
    flex: 1
  },
  conversationName: {
    fontWeight: "600",
    fontSize: "14px",
    marginBottom: "2px"
  },
  lastMessage: {
    fontSize: "12px",
    color: "#64748b",
    overflow: "hidden",
    textOverflow: "ellipsis",
    whiteSpace: "nowrap"
  },
  lastMessageActive: {
    color: "rgba(255,255,255,0.8)"
  },
  timestamp: {
    fontSize: "11px",
    color: "#94a3b8"
  },
  timestampActive: {
    color: "rgba(255,255,255,0.7)"
  },
  chatContainer: {
    flex: 1,
    border: "1px solid #e2e8f0",
    borderRadius: "12px",
    overflow: "hidden",
    display: "flex",
    flexDirection: "column"
  },
  chatHeader: {
    padding: "20px",
    borderBottom: "1px solid #e2e8f0",
    backgroundColor: "#f8fafc",
    display: "flex",
    alignItems: "center",
    gap: "12px"
  },
  chatAvatar: {
    width: "45px",
    height: "45px",
    borderRadius: "50%",
    backgroundColor: "#2563eb",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    color: "white",
    fontWeight: "bold",
    fontSize: "18px"
  },
  chatUserInfo: {
    flex: 1
  },
  chatUserName: {
    fontWeight: "600",
    fontSize: "16px",
    color: "#1e293b"
  },
  chatUserStatus: {
    fontSize: "12px",
    color: "#22c55e"
  },
  messagesContainer: {
    flex: 1,
    padding: "20px",
    overflowY: "auto",
    backgroundColor: "#fafafa",
    display: "flex",
    flexDirection: "column",
    gap: "10px"
  },
  message: {
    maxWidth: "70%",
    padding: "12px 16px",
    borderRadius: "18px",
    fontSize: "14px",
    lineHeight: "1.4",
    position: "relative"
  },
  messageSent: {
    alignSelf: "flex-end",
    backgroundColor: "#2563eb",
    color: "white",
    borderBottomRightRadius: "4px"
  },
  messageReceived: {
    alignSelf: "flex-start",
    backgroundColor: "white",
    color: "#1f2937",
    border: "1px solid #e5e7eb",
    borderBottomLeftRadius: "4px"
  },
  messageTime: {
    fontSize: "11px",
    marginTop: "4px",
    opacity: "0.7"
  },
  messageInputContainer: {
    padding: "20px",
    borderTop: "1px solid #e2e8f0",
    backgroundColor: "white"
  },
  messageInput: {
    width: "100%",
    padding: "12px 16px",
    border: "1px solid #d1d5db",
    borderRadius: "24px",
    fontSize: "14px",
    resize: "none",
    fontFamily: "Arial, sans-serif"
  },
  sendButton: {
    position: "absolute",
    right: "25px",
    bottom: "25px",
    backgroundColor: "#2563eb",
    color: "white",
    border: "none",
    borderRadius: "50%",
    width: "40px",
    height: "40px",
    cursor: "pointer",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    fontSize: "16px"
  },
  emptyState: {
    flex: 1,
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    color: "#64748b",
    textAlign: "center"
  }
};

// Composant pour afficher un message
const Message = ({ message, isSent }) => {
  const messageTime = new Date(message.timestamp).toLocaleTimeString([], { 
    hour: '2-digit', minute: '2-digit' 
  });

  return (
    <div style={{
      ...styles.message,
      ...(isSent ? styles.messageSent : styles.messageReceived)
    }}>
      <div>{message.content}</div>
      <div style={styles.messageTime}>{messageTime}</div>
    </div>
  );
};

export const MessagingView = ({ viewModel, onUpdate }) => {
  const [localHovered, setLocalHovered] = React.useState(null);
  const [selectedConversation, setSelectedConversation] = React.useState(null);
  const [newMessage, setNewMessage] = React.useState('');

  // Données mock pour les conversations
  const conversations = [
    {
      id: 1,
      user: {
        id: 1,
        name: "Sarah Johnson",
        avatar: "SJ",
        status: "online",
        course: "Machine Learning Basics"
      },
      lastMessage: "Thank you for clarifying the assignment requirements!",
      timestamp: new Date(Date.now() - 5 * 60 * 1000), // 5 minutes ago
      unread: 0,
      messages: [
        {
          id: 1,
          content: "Hi, I have a question about the machine learning assignment.",
          timestamp: new Date(Date.now() - 30 * 60 * 1000),
          sender: "user"
        },
        {
          id: 2,
          content: "Of course! What would you like to know?",
          timestamp: new Date(Date.now() - 25 * 60 * 1000),
          sender: "manager"
        },
        {
          id: 3,
          content: "I'm confused about the dataset preprocessing steps.",
          timestamp: new Date(Date.now() - 20 * 60 * 1000),
          sender: "user"
        },
        {
          id: 4,
          content: "Make sure to normalize the features and handle missing values first.",
          timestamp: new Date(Date.now() - 15 * 60 * 1000),
          sender: "manager"
        },
        {
          id: 5,
          content: "Thank you for clarifying the assignment requirements!",
          timestamp: new Date(Date.now() - 5 * 60 * 1000),
          sender: "user"
        }
      ]
    },
    {
      id: 2,
      user: {
        id: 2,
        name: "Mike Wilson",
        avatar: "MW",
        status: "online",
        course: "Advanced Web Development"
      },
      lastMessage: "When will the next project be assigned?",
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000), // 2 hours ago
      unread: 1,
      messages: [
        {
          id: 1,
          content: "Hello, I wanted to ask about the project timeline.",
          timestamp: new Date(Date.now() - 3 * 60 * 60 * 1000),
          sender: "user"
        },
        {
          id: 2,
          content: "The next project will be assigned next Monday.",
          timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
          sender: "manager"
        },
        {
          id: 3,
          content: "When will the next project be assigned?",
          timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
          sender: "user"
        }
      ]
    },
    {
      id: 3,
      user: {
        id: 3,
        name: "Emma Davis",
        avatar: "ED",
        status: "offline",
        course: "Data Analysis with R"
      },
      lastMessage: "The correlation analysis was very helpful.",
      timestamp: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000), // 1 day ago
      unread: 0,
      messages: [
        {
          id: 1,
          content: "I'm working on the correlation analysis exercise.",
          timestamp: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000),
          sender: "user"
        },
        {
          id: 2,
          content: "Great! Let me know if you need any help with interpretation.",
          timestamp: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000),
          sender: "manager"
        },
        {
          id: 3,
          content: "The correlation analysis was very helpful.",
          timestamp: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000),
          sender: "user"
        }
      ]
    }
  ];

  const handleSelectConversation = (conversation) => {
    setSelectedConversation(conversation);
    // Marquer comme lu
    if (conversation.unread > 0) {
      conversation.unread = 0;
      onUpdate();
    }
  };

  const handleSendMessage = () => {
    if (newMessage.trim() && selectedConversation) {
      const message = {
        id: selectedConversation.messages.length + 1,
        content: newMessage.trim(),
        timestamp: new Date(),
        sender: "manager"
      };
      selectedConversation.messages.push(message);
      selectedConversation.lastMessage = newMessage.trim();
      selectedConversation.timestamp = new Date();
      setNewMessage('');
      onUpdate();
    }
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSendMessage();
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

  return (
    <div style={styles.container}>
      <div style={styles.contentSection}>
        <h3 style={styles.sectionTitle}>Messaging</h3>
        
        <div style={styles.messagingContainer}>
          {/* Liste des conversations */}
          <div style={styles.conversationsList}>
            <div style={styles.conversationHeader}>
              <input
                style={styles.searchInput}
                placeholder="Search conversations..."
                type="text"
              />
            </div>
            <div style={styles.conversations}>
              {conversations.map(conversation => (
                <div
                  key={conversation.id}
                  style={{
                    ...styles.conversationItem,
                    ...(selectedConversation?.id === conversation.id ? styles.conversationItemActive : {}),
                    ...(localHovered === conversation.id ? styles.conversationItemHover : {})
                  }}
                  onClick={() => handleSelectConversation(conversation)}
                  onMouseEnter={() => setLocalHovered(conversation.id)}
                  onMouseLeave={() => setLocalHovered(null)}
                >
                  <div style={styles.avatar}>
                    {conversation.user.avatar}
                  </div>
                  <div style={styles.conversationInfo}>
                    <div style={styles.conversationName}>
                      {conversation.user.name}
                    </div>
                    <div style={{
                      ...styles.lastMessage,
                      ...(selectedConversation?.id === conversation.id ? styles.lastMessageActive : {})
                    }}>
                      {conversation.lastMessage}
                    </div>
                  </div>
                  <div style={{
                    ...styles.timestamp,
                    ...(selectedConversation?.id === conversation.id ? styles.timestampActive : {})
                  }}>
                    {getTimeDisplay(conversation.timestamp)}
                  </div>
                  {conversation.unread > 0 && (
                    <div style={{
                      backgroundColor: "#ef4444",
                      color: "white",
                      borderRadius: "50%",
                      width: "20px",
                      height: "20px",
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                      fontSize: "12px",
                      fontWeight: "bold"
                    }}>
                      {conversation.unread}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>

          {/* Zone de chat */}
          <div style={styles.chatContainer}>
            {selectedConversation ? (
              <>
                <div style={styles.chatHeader}>
                  <div style={styles.chatAvatar}>
                    {selectedConversation.user.avatar}
                  </div>
                  <div style={styles.chatUserInfo}>
                    <div style={styles.chatUserName}>
                      {selectedConversation.user.name}
                    </div>
                    <div style={styles.chatUserStatus}>
                      {selectedConversation.user.status === 'online' ? 'Online' : 'Offline'} • {selectedConversation.user.course}
                    </div>
                  </div>
                </div>
                
                <div style={styles.messagesContainer}>
                  {selectedConversation.messages.map(message => (
                    <Message
                      key={message.id}
                      message={message}
                      isSent={message.sender === 'manager'}
                    />
                  ))}
                </div>
                
                <div style={styles.messageInputContainer}>
                  <div style={{ position: 'relative' }}>
                    <textarea
                      style={styles.messageInput}
                      placeholder="Type a message..."
                      value={newMessage}
                      onChange={(e) => setNewMessage(e.target.value)}
                      onKeyPress={handleKeyPress}
                      rows="1"
                    />
                    <button
                      style={styles.sendButton}
                      onClick={handleSendMessage}
                      disabled={!newMessage.trim()}
                    >
                      ↑
                    </button>
                  </div>
                </div>
              </>
            ) : (
              <div style={styles.emptyState}>
                <h3 style={{ color: "#374151", marginBottom: "10px" }}>
                  Select a conversation
                </h3>
                <p style={{ color: "#64748b" }}>
                  Choose a conversation from the list to start messaging
                </p>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};