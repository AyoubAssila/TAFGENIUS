// src/View/Pages/HomePage.jsx
import React from "react";
import { useHomeViewModel } from "../../viewmodel/home_viewmodel";

export default function HomePage() {
  const {
    showSearch,
    searchQuery,
    filteredCourses,
    isSearching,
    searchInputRef,
    coursesContainerRef,
    handleSearchToggle,
    handleSearchChange,
    handleSearchSubmit,
    handleClearSearch,
    handleKeyPress,
    getDisplayedCourses
  } = useHomeViewModel();

  const displayedCourses = getDisplayedCourses();

  const handleImageClick = () => {
    alert("Redirecting to all courses page...");
  };

  const handleGetStarted = () => {
    alert("Redirecting to login page...");
  };

  const styles = {
    container: {
      minHeight: "100vh",
      backgroundColor: "white",
      color: "#1f2937",
      fontFamily: "Arial, sans-serif",
      overflowX: "hidden"
    },
    hero: {
      padding: "60px 24px",
      display: "flex",
      alignItems: "center",
      justifyContent: "space-between",
      maxWidth: "1200px",
      margin: "0 auto",
      gap: "60px"
    },
    heroContent: {
      flex: 1,
      maxWidth: "600px"
    },
    heroTitle: {
      fontSize: "42px",
      fontWeight: "bold",
      color: "#2563eb",
      marginBottom: "20px",
      lineHeight: "1.2"
    },
    heroText: {
      color: "#6b7280",
      marginBottom: "30px",
      fontSize: "20px",
      lineHeight: "1.6"
    },
    heroImage: {
      flex: 1,
      display: "flex",
      justifyContent: "center",
      alignItems: "center"
    },
    imageContainer: {
      width: "450px",
      height: "350px",
      borderRadius: "20px",
      overflow: "hidden",
      boxShadow: "0 12px 35px rgba(0,0,0,0.15)",
      transition: "all 0.4s ease"
    },
    statsText: {
      fontSize: "16px",
      color: "#6b7280",
      marginTop: "20px",
      fontStyle: "italic"
    },
    section: {
      padding: "40px 0",
      maxWidth: "100%",
      margin: "0 auto",
      overflow: "hidden"
    },
    sectionHeader: {
      display: "flex",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: "30px",
      padding: "0 24px",
      maxWidth: "1200px",
      margin: "0 auto 30px"
    },
    sectionTitle: {
      fontSize: "28px",
      fontWeight: "bold",
      color: "#2563eb"
    },
    searchIcon: {
      color: "#2563eb",
      fontSize: "28px",
      cursor: "pointer",
      padding: "12px",
      borderRadius: "50%",
      transition: "all 0.3s ease",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      width: "50px",
      height: "50px"
    },
    searchContainer: {
      display: "flex",
      alignItems: "center",
      maxWidth: "600px",
      margin: "20px auto 0",
      padding: "0 24px",
      position: "relative",
      transition: "all 0.4s ease"
    },
    searchInput: {
      flex: "1",
      border: "2px solid #e5e7eb",
      padding: "18px 60px 18px 24px",
      borderRadius: "50px",
      fontSize: "18px",
      outline: "none",
      transition: "all 0.3s ease",
      backgroundColor: "white",
      boxShadow: "0 4px 15px rgba(0,0,0,0.08)",
      fontFamily: "Arial, sans-serif"
    },
    searchButton: {
      position: "absolute",
      right: "30px",
      backgroundColor: "#2563eb",
      color: "white",
      border: "none",
      borderRadius: "50%",
      width: "50px",
      height: "50px",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      cursor: "pointer",
      transition: "all 0.3s ease",
      fontSize: "20px",
      boxShadow: "0 4px 12px rgba(37, 99, 235, 0.3)"
    },
    clearButton: {
      position: "absolute",
      right: "90px",
      backgroundColor: "transparent",
      color: "#6b7280",
      border: "none",
      borderRadius: "50%",
      width: "40px",
      height: "40px",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      cursor: "pointer",
      transition: "all 0.3s ease",
      fontSize: "18px"
    },
    coursesWrapper: {
      position: "relative",
      width: "100%",
      overflow: "hidden"
    },
    coursesContainer: {
      display: "flex",
      gap: "25px",
      padding: "15px 0",
      width: "max-content"
    },
    coursesContainerAnimated: {
      display: "flex",
      gap: "25px",
      padding: "15px 0",
      width: "max-content",
      animation: "scrollAnimation 60s linear infinite"
    },
    courseCard: {
      border: "2px solid #e5e7eb",
      borderRadius: "16px",
      padding: "25px",
      minWidth: "320px",
      flexShrink: 0,
      transition: "all 0.4s ease",
      cursor: "pointer",
      backgroundColor: "white",
      boxShadow: "0 4px 12px rgba(0,0,0,0.1)"
    },
    courseIcon: {
      fontSize: "40px",
      marginBottom: "15px"
    },
    courseTitle: {
      fontWeight: "600",
      fontSize: "18px",
      marginBottom: "12px"
    },
    courseLessons: {
      color: "#6b7280",
      fontSize: "16px",
      marginBottom: "15px"
    },
    coursePrice: {
      fontWeight: "bold",
      fontSize: "22px",
      color: "#2563eb",
      marginBottom: "20px"
    },
    enrollButton: {
      backgroundColor: "#2563eb",
      color: "white",
      padding: "12px 24px",
      border: "none",
      borderRadius: "10px",
      fontSize: "16px",
      fontWeight: "600",
      cursor: "pointer",
      width: "100%",
      transition: "all 0.3s ease"
    }
  };

  const scrollStyles = `
    @keyframes scrollAnimation {
      0% { transform: translateX(0); }
      100% { transform: translateX(calc(-320px * ${filteredCourses.length} - 25px * (${filteredCourses.length}-1))); }
    }
    .courses-container::-webkit-scrollbar { display: none; }
  `;

  return (
    <div style={styles.container}>
      <style>{scrollStyles}</style>

      {/* ===== HERO SECTION ===== */}
      <section style={styles.hero}>
        <div style={styles.heroContent}>
          <h2 style={styles.heroTitle}>Transform Your Future Starting Today</h2>
          <p style={styles.heroText}>
            Access 5,000+ expert courses and boost your career. 
            <strong> Become the premium version of yourself</strong>
          </p>
          <p style={styles.statsText}>
            Join 100,000+ learners who have already transformed their careers
          </p>
        </div>
        <div style={styles.heroImage}>
          <div style={styles.imageContainer} onClick={handleImageClick}>
            <img 
              src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1471&q=80" 
              alt="Online Learning"
              style={{ width: "100%", height: "100%", objectFit: "cover" }}
            />
          </div>
        </div>
      </section>

      {/* ===== POPULAR COURSES ===== */}
      <section style={styles.section}>
        <div style={styles.sectionHeader}>
          <h3 style={styles.sectionTitle}>Popular Courses ({filteredCourses.length})</h3>
          <div style={styles.searchIcon} onClick={handleSearchToggle}>🔍</div>
        </div>

        {showSearch && (
          <>
            <div style={styles.searchContainer}>
              <input
                ref={searchInputRef}
                type="text"
                placeholder="What do you want to learn today?"
                value={searchQuery}
                onChange={handleSearchChange}
                onKeyPress={handleKeyPress}
                style={styles.searchInput}
              />
              {searchQuery && (
                <button style={styles.clearButton} onClick={handleClearSearch}>✕</button>
              )}
              <button style={styles.searchButton} onClick={handleSearchSubmit}>🔍</button>
            </div>
          </>
        )}

        <div style={styles.coursesWrapper}>
          <div 
            ref={coursesContainerRef}
            style={isSearching ? styles.coursesContainer : styles.coursesContainerAnimated}
            className="courses-container"
          >
            {displayedCourses.map((course, index) => (
              <div key={index} style={styles.courseCard}>
                <div style={styles.courseIcon}>{course.icon}</div>
                <h4 style={styles.courseTitle}>{course.title}</h4>
                <p style={styles.courseLessons}>{course.lessons} lessons</p>
                <p style={styles.coursePrice}>{course.price}</p>
                <button style={styles.enrollButton}>Enroll now</button>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section style={{ padding: "60px 24px", textAlign: "center" }}>
        <h2 style={{ fontSize: "32px", fontWeight: "bold", color: "#2563eb" }}>Unlock Your Full Potential</h2>
        <p style={{ color: "#6b7280", marginBottom: "30px", fontSize: "20px" }}>
          Join millions of learners from around the world already learning on AFTGENIUS
        </p>
        <button 
          style={{ backgroundColor: "#2563eb", color: "white", padding: "16px 40px", border: "none", borderRadius: "12px", fontSize: "18px", fontWeight: "600", cursor: "pointer" }}
          onClick={handleGetStarted}
        >
          Get Started
        </button>
      </section>
    </div>
  );
}
