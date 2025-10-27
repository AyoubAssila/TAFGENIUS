import React, { useState, useRef, useEffect } from "react";

const courses = {
  popular: [
    { title: "Programming with Python", lessons: 12, price: "50 TND", icon: "🐍" },
    { title: "Digital Marketing", lessons: 8, price: "80 TND", icon: "📈" },
    { title: "Graphic Design", lessons: 10, price: "70 TND", icon: "🎨" },
    { title: "Web Development", lessons: 15, price: "75 TND", icon: "💻" },
    { title: "Data Science", lessons: 14, price: "90 TND", icon: "📊" },
    { title: "Mobile Development", lessons: 13, price: "85 TND", icon: "📱" },
    { title: "UI/UX Design", lessons: 9, price: "65 TND", icon: "🎯" },
    { title: "Cloud Computing", lessons: 11, price: "95 TND", icon: "☁️" },
    { title: "Cyber Security", lessons: 16, price: "100 TND", icon: "🔒" },
    { title: "Artificial Intelligence", lessons: 18, price: "120 TND", icon: "🤖" },
    { title: "Machine Learning", lessons: 17, price: "110 TND", icon: "🧠" },
    { title: "Blockchain Development", lessons: 15, price: "130 TND", icon: "⛓️" },
    { title: "DevOps Engineering", lessons: 14, price: "105 TND", icon: "⚙️" },
    { title: "Full Stack Development", lessons: 20, price: "140 TND", icon: "🚀" },
    { title: "Game Development", lessons: 16, price: "115 TND", icon: "🎮" },
    { title: "Digital Photography", lessons: 8, price: "60 TND", icon: "📷" },
    { title: "Video Editing", lessons: 10, price: "70 TND", icon: "🎬" },
    { title: "Social Media Marketing", lessons: 7, price: "55 TND", icon: "📱" },
    { title: "Content Writing", lessons: 6, price: "45 TND", icon: "✍️" },
    { title: "Project Management", lessons: 12, price: "85 TND", icon: "📋" },
    { title: "Business Analytics", lessons: 11, price: "90 TND", icon: "📈" },
    { title: "Financial Analysis", lessons: 13, price: "95 TND", icon: "💰" },
    { title: "Language Learning", lessons: 20, price: "80 TND", icon: "🗣️" },
    { title: "Public Speaking", lessons: 8, price: "65 TND", icon: "🎤" },
    { title: "Entrepreneurship", lessons: 10, price: "75 TND", icon: "💼" }
  ]
};

const styles = {
  container: {
    minHeight: "100vh",
    backgroundColor: "white",
    color: "#1f2937",
    fontFamily: "Arial, sans-serif",
    overflowX: "hidden"
  },
  header: {
    display: "flex",
    alignItems: "center",
    justifyContent: "space-between",
    padding: "16px 24px",
    backgroundColor: "#2563eb",
    borderBottom: "1px solid #1d4ed8",
    boxShadow: "0 2px 10px rgba(0,0,0,0.1)"
  },
  logo: {
    fontSize: "24px",
    fontWeight: "bold",
    color: "white",
    letterSpacing: "1px"
  },
  headerCenter: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    flex: 1,
    gap: "40px"
  },
  nav: {
    display: "flex",
    gap: "40px",
    fontSize: "18px",
    fontWeight: "600"
  },
  navLink: {
    color: "white",
    textDecoration: "none",
    padding: "12px 20px",
    borderRadius: "8px",
    transition: "all 0.3s ease",
    fontSize: "18px",
    fontWeight: "600"
  },
  navLinkHover: {
    backgroundColor: "rgba(255, 255, 255, 0.1)",
    transform: "scale(1.1)",
  },
  authButtons: {
    display: "flex",
    gap: "16px",
    alignItems: "center",
    fontSize: "16px"
  },
  loginButton: {
    backgroundColor: "transparent",
    color: "white",
    padding: "10px 24px",
    borderRadius: "6px",
    border: "1px solid white",
    fontWeight: "600",
    cursor: "pointer",
    fontSize: "14px",
    transition: "all 0.3s ease"
  },
  signUpButton: {
    backgroundColor: "white",
    color: "#2563eb",
    padding: "10px 24px",
    borderRadius: "6px",
    border: "none",
    fontWeight: "bold",
    cursor: "pointer",
    fontSize: "14px",
    transition: "all 0.3s ease"
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
  searchResultsInfo: {
    textAlign: "center",
    color: "#6b7280",
    fontSize: "16px",
    marginTop: "15px",
    padding: "0 24px"
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
  courseHeader: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "flex-start",
    marginBottom: "20px"
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
  },
  motivationalSection: {
    margin: "40px 24px",
    textAlign: "center",
    maxWidth: "1200px",
    margin: "40px auto"
  },
  motivationalTitle: {
    fontSize: "32px",
    fontWeight: "bold",
    color: "#2563eb",
    marginBottom: "12px"
  },
  motivationalSubtitle: {
    fontSize: "18px",
    color: "#6b7280",
    marginBottom: "30px"
  },
  motivationalImage: {
    borderRadius: "24px",
    overflow: "hidden",
    boxShadow: "0 12px 35px rgba(0,0,0,0.15)",
    cursor: "pointer",
    transition: "all 0.4s ease",
    position: "relative"
  },
  imageOverlay: {
    position: "absolute",
    bottom: 0,
    left: 0,
    right: 0,
    background: "linear-gradient(to top, rgba(0,0,0,0.8), transparent)",
    padding: "40px",
    color: "white",
    textAlign: "left"
  },
  imageTitle: {
    fontSize: "32px",
    fontWeight: "bold",
    marginBottom: "12px"
  },
  imageText: {
    fontSize: "18px",
    marginBottom: "20px",
    lineHeight: "1.5"
  },
  exploreButton: {
    backgroundColor: "#2563eb",
    color: "white",
    padding: "14px 28px",
    border: "none",
    borderRadius: "30px",
    fontSize: "18px",
    fontWeight: "bold",
    cursor: "pointer",
    display: "inline-flex",
    alignItems: "center",
    gap: "10px",
    transition: "all 0.3s ease"
  },
  ctaSection: {
    padding: "60px 24px",
    backgroundColor: "#f9fafb",
    textAlign: "center"
  },
  ctaTitle: {
    fontSize: "32px",
    fontWeight: "bold",
    marginBottom: "20px",
    color: "#2563eb"
  },
  ctaText: {
    color: "#6b7280",
    marginBottom: "30px",
    fontSize: "20px",
    maxWidth: "600px",
    margin: "0 auto 30px",
    lineHeight: "1.6"
  },
  ctaButton: {
    backgroundColor: "#2563eb",
    color: "white",
    padding: "16px 40px",
    border: "none",
    borderRadius: "12px",
    fontSize: "18px",
    fontWeight: "600",
    cursor: "pointer",
    transition: "all 0.3s ease"
  },
  footer: {
    padding: "30px 24px",
    backgroundColor: "#f3f4f6",
    textAlign: "center",
    fontSize: "16px",
    color: "#6b7280"
  },
  footerLinks: {
    display: "flex",
    justifyContent: "center",
    gap: "30px",
    marginBottom: "16px",
    fontSize: "16px"
  }
};

// Styles CSS pour l'animation de défilement plus lente
const scrollStyles = `
@keyframes scrollAnimation {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(calc(-320px * 25 - 25px * 24));
  }
}

.courses-container::-webkit-scrollbar {
  display: none;
}
`;

export default function App() {
  const [showSearch, setShowSearch] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [filteredCourses, setFilteredCourses] = useState(courses.popular);
  const [isSearching, setIsSearching] = useState(false);
  const searchInputRef = useRef(null);
  const coursesContainerRef = useRef(null);

  const handleImageClick = () => {
    alert("Redirecting to all courses page...");
  };

  const handleNavHover = (e, isHovering) => {
    if (isHovering) {
      Object.assign(e.currentTarget.style, styles.navLinkHover);
    } else {
      e.currentTarget.style.backgroundColor = "";
      e.currentTarget.style.transform = "scale(1)";
    }
  };

  const handleSearchToggle = () => {
    const newShowSearch = !showSearch;
    setShowSearch(newShowSearch);
    
    if (newShowSearch) {
      // Focus sur l'input quand la recherche s'ouvre
      setTimeout(() => {
        if (searchInputRef.current) {
          searchInputRef.current.focus();
        }
      }, 100);
    } else {
      setSearchQuery("");
      setFilteredCourses(courses.popular);
      setIsSearching(false);
    }
  };

  const handleSearchChange = (e) => {
    const query = e.target.value;
    setSearchQuery(query);
    
    if (query === "") {
      setFilteredCourses(courses.popular);
      setIsSearching(false);
    } else {
      const filtered = courses.popular.filter(course =>
        course.title.toLowerCase().includes(query.toLowerCase())
      );
      setFilteredCourses(filtered);
      setIsSearching(true);
    }
  };

  const handleSearchSubmit = () => {
    if (searchQuery.trim()) {
      const filtered = courses.popular.filter(course =>
        course.title.toLowerCase().includes(searchQuery.toLowerCase())
      );
      setFilteredCourses(filtered);
      setIsSearching(true);
    }
  };

  const handleClearSearch = () => {
    setSearchQuery("");
    setFilteredCourses(courses.popular);
    setIsSearching(false);
    if (searchInputRef.current) {
      searchInputRef.current.focus();
    }
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      handleSearchSubmit();
    }
  };

  const handleGetStarted = () => {
    alert("Redirecting to login page...");
  };

  // Créer une liste de cours qui se répète pour l'animation
  const getRepeatedCourses = () => {
    return [...filteredCourses, ...filteredCourses, ...filteredCourses];
  };

  const displayedCourses = isSearching ? filteredCourses : getRepeatedCourses();

  return (
    <div style={styles.container}>
      <style>{scrollStyles}</style>
      
      {/* ===== NAVBAR BLEUE AVEC BOUTONS ===== */}
      <header style={styles.header}>
        <h1 style={styles.logo}>TAFGENIUS</h1>
        
        <div style={styles.headerCenter}>
          
          <nav style={styles.nav}>
            <a 
              href="#" 
              style={styles.navLink}
              onMouseEnter={(e) => handleNavHover(e, true)}
              onMouseLeave={(e) => handleNavHover(e, false)}
            >
              Home
            </a>
            <a 
              href="#" 
              style={styles.navLink}
              onMouseEnter={(e) => handleNavHover(e, true)}
              onMouseLeave={(e) => handleNavHover(e, false)}
            >
              Blogs
            </a>
            <a 
              href="#" 
              style={styles.navLink}
              onMouseEnter={(e) => handleNavHover(e, true)}
              onMouseLeave={(e) => handleNavHover(e, false)}
            >
              About
            </a>
          </nav>
        </div>

        <div style={styles.authButtons}>
          <button 
            style={styles.loginButton}
            onMouseEnter={(e) => {
              e.currentTarget.style.backgroundColor = "rgba(255, 255, 255, 0.1)";
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.backgroundColor = "transparent";
            }}
          >
            Log in
          </button>
          <button 
            style={styles.signUpButton}
            onMouseEnter={(e) => {
              e.currentTarget.style.backgroundColor = "#f3f4f6";
              e.currentTarget.style.transform = "scale(1.05)";
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.backgroundColor = "white";
              e.currentTarget.style.transform = "scale(1)";
            }}
          >
            Sign up
          </button>
        </div>
      </header>

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
          <div 
            style={styles.imageContainer}
            onMouseEnter={(e) => {
              e.currentTarget.style.transform = "scale(1.08)";
              e.currentTarget.style.boxShadow = "0 16px 45px rgba(0,0,0,0.25)";
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.transform = "scale(1)";
              e.currentTarget.style.boxShadow = "0 12px 35px rgba(0,0,0,0.15)";
            }}
          >
            <img 
              src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80" 
              alt="Online Learning"
              style={{
                width: "100%",
                height: "100%",
                objectFit: "cover"
              }}
            />
          </div>
        </div>
      </section>

      {/* ===== POPULAR COURSES ===== */}
      <section style={styles.section}>
        <div style={styles.sectionHeader}>
          <h3 style={styles.sectionTitle}>Popular Courses ({filteredCourses.length})</h3>
          <div 
            style={styles.searchIcon}
            onClick={handleSearchToggle}
            onMouseEnter={(e) => {
              e.currentTarget.style.backgroundColor = "#dbeafe";
              e.currentTarget.style.transform = "scale(1.1)";
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.backgroundColor = "transparent";
              e.currentTarget.style.transform = "scale(1)";
            }}
          >
            🔍
          </div>
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
                onFocus={(e) => {
                  e.currentTarget.style.borderColor = "#2563eb";
                  e.currentTarget.style.boxShadow = "0 4px 20px rgba(37, 99, 235, 0.15)";
                  e.currentTarget.style.transform = "scale(1.02)";
                }}
                onBlur={(e) => {
                  e.currentTarget.style.borderColor = "#e5e7eb";
                  e.currentTarget.style.boxShadow = "0 4px 15px rgba(0,0,0,0.08)";
                  e.currentTarget.style.transform = "scale(1)";
                }}
              />
              {searchQuery && (
                <button 
                  style={styles.clearButton}
                  onClick={handleClearSearch}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.backgroundColor = "#f3f4f6";
                    e.currentTarget.style.color = "#374151";
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.backgroundColor = "transparent";
                    e.currentTarget.style.color = "#6b7280";
                  }}
                >
                  ✕
                </button>
              )}
              <button 
                style={styles.searchButton}
                onClick={handleSearchSubmit}
                onMouseEnter={(e) => {
                  e.currentTarget.style.backgroundColor = "#1d4ed8";
                  e.currentTarget.style.transform = "scale(1.1)";
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.backgroundColor = "#2563eb";
                  e.currentTarget.style.transform = "scale(1)";
                }}
              >
                🔍
              </button>
            </div>
            {isSearching && (
              <div style={styles.searchResultsInfo}>
                Found {filteredCourses.length} course{filteredCourses.length !== 1 ? 's' : ''} for "{searchQuery}"
              </div>
            )}
          </>
        )}
        
        <div style={styles.coursesWrapper}>
          <div 
            ref={coursesContainerRef}
            style={isSearching ? styles.coursesContainer : styles.coursesContainerAnimated}
            className="courses-container"
          >
            {displayedCourses.map((course, index) => (
              <div 
                key={index} 
                style={styles.courseCard}
                onMouseEnter={(e) => {
                  e.currentTarget.style.transform = "translateY(-12px) scale(1.02)";
                  e.currentTarget.style.boxShadow = "0 16px 40px rgba(0,0,0,0.2)";
                  e.currentTarget.style.borderColor = "#2563eb";
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.transform = "translateY(0) scale(1)";
                  e.currentTarget.style.boxShadow = "0 4px 12px rgba(0,0,0,0.1)";
                  e.currentTarget.style.borderColor = "#e5e7eb";
                }}
              >
                <div style={styles.courseIcon}>{course.icon}</div>
                <div style={styles.courseHeader}>
                  <div>
                    <h4 style={styles.courseTitle}>{course.title}</h4>
                    <p style={styles.courseLessons}>{course.lessons} lessons</p>
                    <p style={styles.coursePrice}>{course.price}</p>
                  </div>
                </div>
                <button 
                  style={styles.enrollButton}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.backgroundColor = "#1d4ed8";
                    e.currentTarget.style.transform = "scale(1.08)";
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.backgroundColor = "#2563eb";
                    e.currentTarget.style.transform = "scale(1)";
                  }}
                >
                  Enroll now
                </button>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Rest of the component remains the same */}
      <section style={styles.motivationalSection}>
        <h2 style={styles.motivationalTitle}>Your Learning Journey Starts Here</h2>
        <p style={styles.motivationalSubtitle}>
          Discover your passion, master new skills, and achieve your dreams
        </p>
        
        <div 
          style={styles.motivationalImage}
          onClick={handleImageClick}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = "scale(1.03)";
            e.currentTarget.style.boxShadow = "0 16px 45px rgba(0,0,0,0.25)";
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = "scale(1)";
            e.currentTarget.style.boxShadow = "0 12px 35px rgba(0,0,0,0.15)";
          }}
        >
          <img 
            src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
            alt="Learning Journey"
            style={{
              width: "100%",
              height: "350px",
              objectFit: "cover",
              display: "block"
            }}
          />
          <div style={styles.imageOverlay}>
            <h3 style={styles.imageTitle}>Ready to Start Your Success Story?</h3>
            <p style={styles.imageText}>
              Click here to explore all our courses and begin your transformation journey today!
            </p>
            <button 
              style={styles.exploreButton}
              onMouseEnter={(e) => {
                e.currentTarget.style.backgroundColor = "#1d4ed8";
                e.currentTarget.style.transform = "scale(1.05)";
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.backgroundColor = "#2563eb";
                e.currentTarget.style.transform = "scale(1)";
              }}
            >
              Explore All Courses
            </button>
          </div>
        </div>
      </section>

      <section style={styles.ctaSection}>
        <h2 style={styles.ctaTitle}>Unlock Your Full Potential</h2>
        <p style={styles.ctaText}>
          Join millions of learners from around the world already learning on AFTGENIUS
        </p>
        <button 
          style={styles.ctaButton}
          onClick={handleGetStarted}
          onMouseEnter={(e) => {
            e.currentTarget.style.backgroundColor = "#1d4ed8";
            e.currentTarget.style.transform = "scale(1.05)";
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.backgroundColor = "#2563eb";
            e.currentTarget.style.transform = "scale(1)";
          }}
        >
          Get Started
        </button>
      </section>

      <footer style={styles.footer}>
        <div style={styles.footerLinks}>
          <span>Contact</span>
          <span>Legal Notice</span>
          <span>Useful Links</span>
          <span>Social Media</span>
        </div>
        <div>AFTGENIUS - Your Excellence Training Partner</div>
      </footer>
    </div>
  );
}