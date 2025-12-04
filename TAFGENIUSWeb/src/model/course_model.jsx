// src/Model/course_model.jsx
export const CourseModel = {
  id: "",           // facultatif si on veut un identifiant unique
  title: "",
  lessons: "",
  price: "",
  progress: 0,      // 0 à 1
  instructor: "",
  date: "",
  chapters: [],     // tableau de titres
  videos: [],       // tableau de noms fichiers vidéos
  meetDates: [],    // tableau de dates
};

// Données des cours
export const CoursesData = [
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
];
