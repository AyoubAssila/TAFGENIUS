// src/ViewModel/course_viewmodel.jsx
import { useState } from "react";
import { CourseModel } from "../model/course_model";

export function useCourseViewModel() {
  const [myCourses, setMyCourses] = useState([
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
  ]);

  const [recommended, setRecommended] = useState([
    { title: "Python for Beginners", lessons: "10 lessons", price: "30 TND" },
    { title: "UI/UX Design Masterclass", lessons: "15 lessons", price: "50 TND" },
  ]);

  const [search, setSearch] = useState("");

  const filteredMyCourses = myCourses.filter(c =>
    c.title.toLowerCase().includes(search.toLowerCase())
  );

  const filteredRecommended = recommended.filter(c =>
    c.title.toLowerCase().includes(search.toLowerCase())
  );

  return {
    myCourses,
    recommended,
    search,
    setSearch,
    filteredMyCourses,
    filteredRecommended,
  };
}
