import React from 'react';

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
    maxWidth: "500px",
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
    transition: "all 0.3s ease",
    zIndex: 10
  },
  title: {
    fontSize: "24px",
    fontWeight: "bold",
    marginBottom: "20px",
    color: "#1e293b",
    paddingRight: "40px"
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
  actions: {
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
  }
};

export const NewCourseModal = ({ viewModel, onUpdate }) => {
  const handleCreate = () => {
    const result = viewModel.createCourse();
    if (result) {
      onUpdate();
    }
  };

  const handleClose = () => {
    viewModel.setShowNewCourseModal(false);
    onUpdate();
  };

  return (
    <div style={modalStyles.overlay} onClick={handleClose}>
      <div style={modalStyles.content} onClick={e => e.stopPropagation()}>
        <button 
          style={modalStyles.closeButton}
          onClick={handleClose}
          onMouseEnter={(e) => e.target.style.backgroundColor = "#f3f4f6"}
          onMouseLeave={(e) => e.target.style.backgroundColor = "transparent"}
        >
          ×
        </button>
        
        <h2 style={modalStyles.title}>Create New Course</h2>
        
        <div style={modalStyles.inputGroup}>
          <label style={modalStyles.label}>Course Title *</label>
          <input 
            style={modalStyles.input} 
            placeholder="Ex: Advanced Python Programming" 
            value={viewModel.newCourse.title}
            onChange={(e) => {
              viewModel.updateNewCourse('title', e.target.value);
              onUpdate();
            }}
          />
        </div>
        
        <div style={modalStyles.inputGroup}>
          <label style={modalStyles.label}>Category *</label>
          <input 
            style={modalStyles.input} 
            placeholder="Ex: Web Development, Data Science" 
            value={viewModel.newCourse.category}
            onChange={(e) => {
              viewModel.updateNewCourse('category', e.target.value);
              onUpdate();
            }}
          />
        </div>
        
        <div style={modalStyles.inputGroup}>
          <label style={modalStyles.label}>Description</label>
          <textarea 
            style={modalStyles.textarea} 
            placeholder="Describe what students will learn in this course..." 
            value={viewModel.newCourse.description}
            onChange={(e) => {
              viewModel.updateNewCourse('description', e.target.value);
              onUpdate();
            }}
          />
        </div>
        
        <div style={modalStyles.actions}>
          <button 
            style={modalStyles.cancelButton}
            onClick={handleClose}
          >
            Cancel
          </button>
          <button 
            style={{
              ...modalStyles.confirmButton,
              opacity: (!viewModel.newCourse.title || !viewModel.newCourse.category) ? 0.6 : 1,
              cursor: (!viewModel.newCourse.title || !viewModel.newCourse.category) ? "not-allowed" : "pointer"
            }}
            onClick={handleCreate}
            disabled={!viewModel.newCourse.title || !viewModel.newCourse.category}
          >
            Create Course
          </button>
        </div>
      </div>
    </div>
  );
};

export const NewLiveModal = ({ viewModel, onUpdate }) => {
  const handleCreate = () => {
    const result = viewModel.createLiveSession();
    if (result) {
      onUpdate();
    }
  };

  const handleClose = () => {
    viewModel.setShowNewLiveModal(false);
    onUpdate();
  };

  return (
    <div style={modalStyles.overlay} onClick={handleClose}>
      <div style={modalStyles.content} onClick={e => e.stopPropagation()}>
        <button 
          style={modalStyles.closeButton}
          onClick={handleClose}
          onMouseEnter={(e) => e.target.style.backgroundColor = "#f3f4f6"}
          onMouseLeave={(e) => e.target.style.backgroundColor = "transparent"}
        >
          ×
        </button>
        
        <h2 style={modalStyles.title}>Schedule Live Session</h2>
        
        <div style={modalStyles.inputGroup}>
          <label style={modalStyles.label}>Session Title *</label>
          <input 
            style={modalStyles.input} 
            placeholder="Ex: Python Q&A Session" 
            value={viewModel.newLive.title}
            onChange={(e) => {
              viewModel.updateNewLive('title', e.target.value);
              onUpdate();
            }}
          />
        </div>
        
        <div style={modalStyles.inputGroup}>
          <label style={modalStyles.label}>Date & Time *</label>
          <input 
            style={modalStyles.input} 
            type="datetime-local" 
            value={viewModel.newLive.datetime}
            onChange={(e) => {
              viewModel.updateNewLive('datetime', e.target.value);
              onUpdate();
            }}
          />
        </div>
        
        <div style={modalStyles.inputGroup}>
          <label style={modalStyles.label}>Description</label>
          <textarea 
            style={modalStyles.textarea} 
            placeholder="Describe what you'll cover in this live session..." 
            value={viewModel.newLive.description}
            onChange={(e) => {
              viewModel.updateNewLive('description', e.target.value);
              onUpdate();
            }}
          />
        </div>
        
        <div style={modalStyles.actions}>
          <button 
            style={modalStyles.cancelButton}
            onClick={handleClose}
          >
            Cancel
          </button>
          <button 
            style={{
              ...modalStyles.confirmButton,
              opacity: (!viewModel.newLive.title || !viewModel.newLive.datetime) ? 0.6 : 1,
              cursor: (!viewModel.newLive.title || !viewModel.newLive.datetime) ? "not-allowed" : "pointer"
            }}
            onClick={handleCreate}
            disabled={!viewModel.newLive.title || !viewModel.newLive.datetime}
          >
            Schedule Session
          </button>
        </div>
      </div>
    </div>
  );
};