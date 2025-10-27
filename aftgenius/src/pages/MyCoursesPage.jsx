import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { BiSearch } from "react-icons/bi";

export default function MyCoursesPage() {
  const [search, setSearch] = useState("");
  const navigate = useNavigate();

  const myCourses = [
    { 
      title: "React Basics", 
      lessons: "12 lessons", 
      price: "Free", 
      progress: 0.6,
      instructor: "John Doe",
      date: "2024-01-15",
      chapters: ["Introduction", "JSX", "Components", "State & Props"],
      videos: ["Intro.mp4", "JSX.mp4", "Components.mp4"],
      meetDates: [new Date("2024-02-01"), new Date("2024-02-08")]
    },
    { 
      title: "Advanced Flutter", 
      lessons: "8 lessons", 
      price: "40 TND", 
      progress: 0.3,
      instructor: "Jane Smith",
      date: "2024-03-01",
      chapters: ["Setup", "Widgets", "State Management"],
      videos: ["Setup.mp4", "Widgets.mp4"],
      meetDates: []
    },
  ];

  const recommended = [
    { title: "Python for Beginners", lessons: "10 lessons", price: "30 TND" },
    { title: "UI/UX Design Masterclass", lessons: "15 lessons", price: "50 TND" },
  ];

  const renderCourseCard = (course, key) => (
    <div
      key={key}
      style={{
        background: "#fff",
        borderRadius: "12px",
        boxShadow: "0px 3px 8px rgba(0,0,0,0.1)",
        padding: "16px",
        transition: "transform 0.2s, box-shadow 0.2s",
        cursor: "pointer",
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.transform = "translateY(-4px)";
        e.currentTarget.style.boxShadow = "0px 5px 12px rgba(0,0,0,0.15)";
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.transform = "translateY(0)";
        e.currentTarget.style.boxShadow = "0px 3px 8px rgba(0,0,0,0.1)";
      }}
      onClick={() => navigate("/coursedetail", { state: { course } })}
    >
      <h4 style={{ margin: "0 0 6px 0", color: "#000" }}>{course.title}</h4>
      <p style={{ margin: "0 0 10px 0", color: "#666" }}>{course.lessons}</p>
      <p style={{ fontWeight: "bold", color: "#333" }}>{course.price}</p>
      {course.progress !== undefined && (
        <div style={{ marginTop: "10px" }}>
          <div style={{ height: "8px", borderRadius: "5px", background: "#e0e0e0" }}>
            <div
              style={{
                width: `${course.progress * 100}%`,
                height: "8px",
                borderRadius: "5px",
                background: "#1976d2",
                transition: "width 0.3s ease",
              }}
            ></div>
          </div>
          <p style={{ fontSize: "12px", marginTop: "4px", color: "#555" }}>
            {Math.round(course.progress * 100)}% completed
          </p>
        </div>
      )}
    </div>
  );

  const filteredMyCourses = myCourses.filter((c) =>
    c.title.toLowerCase().includes(search.toLowerCase())
  );

  const filteredRecommended = recommended.filter((c) =>
    c.title.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div
      style={{
        padding: "30px",
        marginLeft: "240px",
        maxWidth: "900px",
        marginRight: "auto",
        marginTop: "50px",
      }}
    >
      <div style={{ position: "relative", marginBottom: "30px" }}>
        <BiSearch
          style={{
            position: "absolute",
            top: "50%",
            left: "12px",
            transform: "translateY(-50%)",
            color: "#888",
            fontSize: "20px",
          }}
        />
        <input
          type="text"
          placeholder="Search courses..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          style={{
            width: "100%",
            padding: "10px 15px 10px 40px",
            borderRadius: "8px",
            border: "1px solid #ccc",
            fontSize: "16px",
          }}
        />
      </div>

      <h2 style={{ fontWeight: "700", color: "#000", marginBottom: "20px" }}>My Courses</h2>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(280px, 1fr))", gap: "20px" }}>
        {filteredMyCourses.map(renderCourseCard)}
      </div>

      <h3 style={{ marginTop: "50px", fontWeight: "700", color: "#000", fontSize: "1.5rem" }}>Recommended Courses</h3>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(280px, 1fr))", gap: "20px", marginTop: "10px" }}>
        {filteredRecommended.map(renderCourseCard)}
      </div>
    </div>
  );
}
