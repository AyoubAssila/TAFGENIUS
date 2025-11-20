import React from 'react';
import { NewCourseModal } from '../components/Modals';

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
  coursesGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fill, minmax(320px, 1fr))",
    gap: "20px"
  },
  courseCard: {
    border: "1px solid #e2e8f0",
    borderRadius: "12px",
    padding: "20px",
    transition: "all 0.3s ease",
    backgroundColor: "#fafafa"
  },
  courseCardHover: {
    borderColor: "#2563eb",
    backgroundColor: "#f0f9ff",
    transform: "translateY(-2px)",
    boxShadow: "0 4px 12px rgba(37, 99, 235, 0.1)"
  },
  courseHeader: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "flex-start",
    marginBottom: "15px"
  },
  courseTitle: {
    fontWeight: "600",
    fontSize: "18px",
    color: "#1e293b",
    marginBottom: "5px"
  },
  courseCategory: {
    color: "#64748b",
    fontSize: "14px",
    backgroundColor: "#e2e8f0",
    padding: "2px 8px",
    borderRadius: "4px",
    display: "inline-block"
  },
  courseStatus: {
    padding: "4px 12px",
    borderRadius: "20px",
    fontSize: "12px",
    fontWeight: "600"
  },
  statusPublished: {
    backgroundColor: "#dcfce7",
    color: "#166534",
    border: "1px solid #bbf7d0"
  },
  statusDraft: {
    backgroundColor: "#fef3c7",
    color: "#92400e",
    border: "1px solid #fde68a"
  },
  threadMeta: {
    display: "flex",
    gap: "15px",
    fontSize: "13px",
    color: "#94a3b8",
    marginBottom: "15px",
    padding: "10px 0",
    borderTop: "1px solid #e5e7eb",
    borderBottom: "1px solid #e5e7eb"
  },
  courseActions: {
    display: "flex",
    gap: "10px",
    marginTop: "15px"
  },
  actionButton: {
    padding: "8px 16px",
    borderRadius: "8px",
    border: "none",
    cursor: "pointer",
    fontSize: "14px",
    transition: "all 0.3s ease",
    flex: 1,
    fontWeight: "500"
  },
  editButton: {
    backgroundColor: "#dbeafe",
    color: "#2563eb",
    border: "1px solid #bfdbfe"
  },
  deleteButton: {
    backgroundColor: "#fee2e2",
    color: "#dc2626",
    border: "1px solid #fecaca"
  },
  publishButton: {
    backgroundColor: "#dcfce7",
    color: "#166534",
    border: "1px solid #bbf7d0"
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
  // Styles pour le modal d'édition
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
  select: {
    width: "100%",
    padding: "12px 16px",
    border: "2px solid #d1d5db",
    borderRadius: "8px",
    fontSize: "16px",
    backgroundColor: "white",
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

// Composant modal pour éditer un cours
const EditCourseModal = ({ course, onClose, onUpdate }) => {
  const [title, setTitle] = React.useState(course?.title || '');
  const [category, setCategory] = React.useState(course?.category || '');
  const [description, setDescription] = React.useState(course?.description || '');
  const [status, setStatus] = React.useState(course?.status || 'draft');

  const handleSave = () => {
    if (course) {
      // Mettre à jour le cours existant
      course.title = title;
      course.category = category;
      course.description = description;
      course.status = status;
      
      // Mettre à jour la date de dernière modification
      course.lastUpdated = new Date().toISOString().split('T')[0];
      
      onUpdate();
    }
    onClose();
  };

  const handlePublish = () => {
    if (course) {
      course.status = 'published';
      course.lastUpdated = new Date().toISOString().split('T')[0];
      onUpdate();
      onClose();
    }
  };

  const handleUnpublish = () => {
    if (course) {
      course.status = 'draft';
      course.lastUpdated = new Date().toISOString().split('T')[0];
      onUpdate();
      onClose();
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

        <h2 style={styles.modalTitle}>Edit Course</h2>
        
        <div style={styles.inputGroup}>
          <label style={styles.label}>Course Title *</label>
          <input
            style={styles.input}
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Ex: Advanced Python Programming"
          />
        </div>

        <div style={styles.inputGroup}>
          <label style={styles.label}>Category *</label>
          <input
            style={styles.input}
            type="text"
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            placeholder="Ex: Web Development, Data Science"
          />
        </div>

        <div style={styles.inputGroup}>
          <label style={styles.label}>Status</label>
          <select
            style={styles.select}
            value={status}
            onChange={(e) => setStatus(e.target.value)}
          >
            <option value="draft">Draft</option>
            <option value="published">Published</option>
          </select>
        </div>

        <div style={styles.inputGroup}>
          <label style={styles.label}>Description</label>
          <textarea
            style={styles.textarea}
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Describe what students will learn in this course..."
            rows="4"
          />
        </div>

        <div style={{ 
          backgroundColor: "#f8fafc", 
          padding: "15px", 
          borderRadius: "8px", 
          marginBottom: "20px",
          border: "1px solid #e2e8f0"
        }}>
          <h4 style={{ color: "#374151", marginBottom: "10px" }}>Course Information</h4>
          <div style={{ fontSize: "14px", color: "#64748b" }}>
            <div>Students enrolled: <strong>{course?.students || 0}</strong></div>
            <div>Last updated: <strong>{course?.lastUpdated || 'Never'}</strong></div>
            <div>Course ID: <strong>{course?.id}</strong></div>
          </div>
        </div>

        <div style={styles.modalActions}>
          {course?.status === 'published' ? (
            <button 
              style={{...styles.cancelButton, backgroundColor: "#f59e0b"}}
              onClick={handleUnpublish}
            >
              Unpublish
            </button>
          ) : (
            <button 
              style={{...styles.cancelButton, backgroundColor: "#22c55e"}}
              onClick={handlePublish}
              disabled={!title.trim() || !category.trim()}
            >
              Publish Now
            </button>
          )}
          <button 
            style={styles.confirmButton}
            onClick={handleSave}
            disabled={!title.trim() || !category.trim()}
          >
            Save Changes
          </button>
        </div>
      </div>
    </div>
  );
};

export const CoursesView = ({ viewModel, onUpdate }) => {
  const [localHovered, setLocalHovered] = React.useState(null);
  const [showNewModal, setShowNewModal] = React.useState(false);
  const [showEditModal, setShowEditModal] = React.useState(false);
  const [selectedCourse, setSelectedCourse] = React.useState(null);

  // Synchroniser avec le viewModel
  React.useEffect(() => {
    if (viewModel.showNewCourseModal !== showNewModal) {
      setShowNewModal(viewModel.showNewCourseModal);
    }
  }, [viewModel.showNewCourseModal]);

  const handleShowNewModal = () => {
    // Réinitialiser les champs du nouveau cours
    viewModel.updateNewCourse('title', '');
    viewModel.updateNewCourse('category', '');
    viewModel.updateNewCourse('description', '');
    
    viewModel.setShowNewCourseModal(true);
    setShowNewModal(true);
    onUpdate();
  };

  const handleCloseNewModal = () => {
    viewModel.setShowNewCourseModal(false);
    setShowNewModal(false);
    onUpdate();
  };

  const handleShowEditModal = (course) => {
    setSelectedCourse(course);
    setShowEditModal(true);
  };

  const handleCloseEditModal = () => {
    setShowEditModal(false);
    setSelectedCourse(null);
  };

  const handleDeleteCourse = (courseId) => {
    if (window.confirm('Are you sure you want to delete this course? This action cannot be undone.')) {
      viewModel.deleteCourse(courseId);
      onUpdate();
    }
  };

  const handlePublishCourse = (courseId) => {
    const course = viewModel.courses.find(c => c.id === courseId);
    if (course) {
      course.status = 'published';
      course.lastUpdated = new Date().toISOString().split('T')[0];
      onUpdate();
    }
  };

  const handleUnpublishCourse = (courseId) => {
    const course = viewModel.courses.find(c => c.id === courseId);
    if (course) {
      course.status = 'draft';
      course.lastUpdated = new Date().toISOString().split('T')[0];
      onUpdate();
    }
  };

  return (
    <div style={styles.container}>
      <div style={styles.contentSection}>
        <div style={styles.headerActions}>
          <h3 style={styles.sectionTitle}>Course Management</h3>
          <div style={{ display: "flex", alignItems: "center", gap: "15px" }}>
            <div style={styles.statsInfo}>
              {viewModel.courses.length} courses • {viewModel.courses.filter(c => c.status === 'published').length} published • {viewModel.courses.filter(c => c.status === 'draft').length} drafts
            </div>
            <button 
              style={styles.scheduleButton}
              onClick={handleShowNewModal}
              onMouseEnter={(e) => e.target.style.transform = "scale(1.05)"}
              onMouseLeave={(e) => e.target.style.transform = "scale(1)"}
            >
              New Course
            </button>
          </div>
        </div>
        
        {viewModel.courses.length === 0 ? (
          <div style={{ 
            textAlign: "center", 
            padding: "60px 20px", 
            color: "#64748b",
            backgroundColor: "#f8fafc",
            borderRadius: "12px",
            border: "2px dashed #e2e8f0"
          }}>
            <h3 style={{ color: "#374151", marginBottom: "10px" }}>No Courses Yet</h3>
            <p style={{ marginBottom: "20px" }}>Create your first course to get started</p>
            <button 
              style={styles.scheduleButton}
              onClick={handleShowNewModal}
            >
              Create Your First Course
            </button>
          </div>
        ) : (
          <div style={styles.coursesGrid}>
            {viewModel.courses.map(course => (
              <div 
                key={course.id}
                style={{
                  ...styles.courseCard,
                  ...(localHovered === `course-${course.id}` ? styles.courseCardHover : {})
                }}
                onMouseEnter={() => setLocalHovered(`course-${course.id}`)}
                onMouseLeave={() => setLocalHovered(null)}
              >
                <div style={styles.courseHeader}>
                  <div style={{ flex: 1 }}>
                    <div style={styles.courseTitle}>{course.title}</div>
                    <div style={styles.courseCategory}>{course.category}</div>
                  </div>
                  <div style={{
                    ...styles.courseStatus,
                    ...(course.status === 'published' ? styles.statusPublished : styles.statusDraft)
                  }}>
                    {course.status === 'published' ? 'Published' : 'Draft'}
                  </div>
                </div>
                
                <div style={styles.threadMeta}>
                  <span>{course.students} students</span>
                  <span>Updated: {course.lastUpdated}</span>
                </div>
                
                <p style={{ 
                  color: "#64748b", 
                  fontSize: "14px", 
                  marginBottom: "15px",
                  lineHeight: "1.4" 
                }}>
                  {course.description || "No description available."}
                </p>
                
                <div style={styles.courseActions}>
                  <button 
                    style={{...styles.actionButton, ...styles.editButton}}
                    onClick={() => handleShowEditModal(course)}
                  >
                    Edit
                  </button>
                  {course.status === 'published' ? (
                    <button 
                      style={{...styles.actionButton, ...styles.publishButton}}
                      onClick={() => handleUnpublishCourse(course.id)}
                    >
                      Unpublish
                    </button>
                  ) : (
                    <button 
                      style={{...styles.actionButton, ...styles.publishButton}}
                      onClick={() => handlePublishCourse(course.id)}
                    >
                      Publish
                    </button>
                  )}
                  <button 
                    style={{...styles.actionButton, ...styles.deleteButton}}
                    onClick={() => handleDeleteCourse(course.id)}
                  >
                    Delete
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {/* Modal pour créer un nouveau cours */}
        {(showNewModal || viewModel.showNewCourseModal) && (
          <NewCourseModal 
            viewModel={viewModel} 
            onUpdate={onUpdate}
            onClose={handleCloseNewModal}
          />
        )}

        {/* Modal pour éditer un cours existant */}
        {showEditModal && selectedCourse && (
          <EditCourseModal 
            course={selectedCourse}
            onClose={handleCloseEditModal}
            onUpdate={onUpdate}
          />
        )}
      </div>
    </div>
  );
};