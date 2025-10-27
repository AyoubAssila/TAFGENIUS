import React from "react";
import { useLocation, useNavigate } from "react-router-dom";
import Navbar from "../components/Navbar";

export default function CourseDetailPage() {
  const location = useLocation();
  const navigate = useNavigate();

  const course = location.state?.course;

  if (!course) {
    return (
      <div>
        <Navbar />
        <div style={{ padding: "30px", textAlign: "center" }}>
          <h2>Course not found</h2>
          <button
            onClick={() => navigate("/mycourses")}
            style={{
              marginTop: "20px",
              padding: "10px 20px",
              borderRadius: "8px",
              border: "none",
              background: "#1976d2",
              color: "white",
              cursor: "pointer",
            }}
          >
            Back to My Courses
          </button>
        </div>
      </div>
    );
  }

  const ProgressCircle = ({ progress }) => {
    const radius = 60;
    const stroke = 8;
    const normalizedRadius = radius - stroke * 2;
    const circumference = normalizedRadius * 2 * Math.PI;
    const strokeDashoffset = circumference - progress * circumference;

    return (
      <svg height={radius * 2} width={radius * 2}>
        <circle
          stroke="#e0e0e0"
          fill="transparent"
          strokeWidth={stroke}
          r={normalizedRadius}
          cx={radius}
          cy={radius}
        />
        <circle
          stroke="#1976d2"
          fill="transparent"
          strokeWidth={stroke}
          strokeLinecap="round"
          r={normalizedRadius}
          cx={radius}
          cy={radius}
          strokeDasharray={circumference + " " + circumference}
          strokeDashoffset={strokeDashoffset}
          style={{ transition: "stroke-dashoffset 0.5s" }}
        />
        <text
          x="50%"
          y="50%"
          dominantBaseline="middle"
          textAnchor="middle"
          fontSize="18px"
          fontWeight="bold"
          fill="#1976d2"
        >
          {Math.round(progress * 100)}%
        </text>
      </svg>
    );
  };

  return (
    <div style={{ marginLeft: "240px" }}>
      <Navbar />
      <div style={{ padding: "30px", maxWidth: "900px", margin: "0 auto" }}>
        <h1 style={{ color: "#1976d2", marginBottom: "16px" }}>{course.title}</h1>
        <p><b>Instructor:</b> {course.instructor || "TBD"}</p>
        <p><b>Start Date:</b> {course.date || "TBD"}</p>

        <div style={{ display: "flex", gap: "30px", alignItems: "center", marginTop: "20px" }}>
          <ProgressCircle progress={course.progress} />
          <p style={{ fontSize: "16px" }}>Your course progress</p>
        </div>

        {/* Chapters */}
        <section style={{ marginTop: "30px" }}>
          <h3>Chapters</h3>
          <ul style={{ paddingLeft: "20px", listStyleType: "none" }}>
            {course.chapters?.map((chapter, i) => (
              <li
                key={i}
                style={{
                  padding: "10px",
                  marginBottom: "8px",
                  background: "#f5f5f5",
                  borderRadius: "8px",
                  cursor: "pointer",
                  transition: "0.2s",
                }}
                onClick={() => alert(`Open chapter: ${chapter}`)}
                onMouseEnter={(e) => e.currentTarget.style.background = "#e0f0ff"}
                onMouseLeave={(e) => e.currentTarget.style.background = "#f5f5f5"}
              >
                {chapter}
              </li>
            ))}
          </ul>
        </section>

        {/* Videos */}
        <section style={{ marginTop: "20px" }}>
          <h3>Videos</h3>
          <ul style={{ paddingLeft: "20px", listStyleType: "none" }}>
            {course.videos?.map((video, i) => (
              <li
                key={i}
                style={{
                  padding: "10px",
                  marginBottom: "8px",
                  background: "#f5f5f5",
                  borderRadius: "8px",
                  cursor: "pointer",
                  transition: "0.2s",
                }}
                onClick={() => alert(`Play video: ${video}`)}
                onMouseEnter={(e) => e.currentTarget.style.background = "#e0f0ff"}
                onMouseLeave={(e) => e.currentTarget.style.background = "#f5f5f5"}
              >
                {video}
              </li>
            ))}
          </ul>
        </section>

        {/* Boutons côte à côte */}
        <div style={{ display: "flex", gap: "16px", marginTop: "30px" }}>
          <button
            disabled={course.progress < 1}
            onClick={() => alert("Start Quiz")}
            style={{
              flex: 1,
              padding: "14px",
              background: course.progress < 1 ? "#aaa" : "#1976d2",
              color: "white",
              border: "none",
              borderRadius: "12px",
              fontWeight: "600",
              cursor: course.progress < 1 ? "not-allowed" : "pointer",
              transition: "0.2s",
            }}
          >
            Take Quiz
          </button>

          <button
            onClick={() => navigate("/mycourses")}
            style={{
              flex: 1,
              padding: "14px",
              borderRadius: "12px",
              border: "none",
              background: "#1976d2",
              color: "white",
              cursor: "pointer",
              fontWeight: "600",
              transition: "0.2s",
            }}
            onMouseEnter={(e) => e.currentTarget.style.background = "#145ea8"}
            onMouseLeave={(e) => e.currentTarget.style.background = "#1976d2"}
          >
            Back to My Courses
          </button>
        </div>
      </div>
    </div>
  );
}
