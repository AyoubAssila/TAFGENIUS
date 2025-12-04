import { useState } from "react";
import { TeamMember, AboutSection } from "../model/about_model";

export function useAboutViewModel() {
  const [sections] = useState([
    new AboutSection(
      "Who We Are",
      "We are a passionate team of computer science students driven by innovation and learning. " +
        "Our project focuses on building a modern educational platform that offers accessible, " +
        "high-quality learning experiences to students and the general public. " +
        "We believe that technology can make education easier, faster, and more effective."
    ),
    new AboutSection(
      "Our Mission",
      "Our mission is to create a secure and user-friendly educational platform where learners can access professional courses " +
        "and resources anytime, anywhere. We aim to support education through digital transformation by integrating local payment " +
        "solutions like Paymee Sandbox in Tunisia."
    ),
    new AboutSection(
      "Our History",
      "This project began as a university initiative to develop a complete web and mobile application using modern technologies. " +
        "Our goal was to create an educational solution that allows users to learn, pay securely, and track their progress easily. " +
        "Throughout our journey, we've learned how to work as a team, solve real-world problems, and design a platform that combines " +
        "technology, accessibility, and education."
    ),
    new AboutSection(
      "Our Vision",
      "We aspire to expand our platform beyond its initial prototype, turning it into a real tool that empowers learners " +
        "and educators in Tunisia and beyond. Our long-term vision is to make education more digital, inclusive, and innovative."
    ),
  ]);

  const [teamMembers] = useState([
    new TeamMember(
      "Feriel Khalfaoui",
      "Frontend Developer & UX Designer",
      "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
    ),
    new TeamMember(
      "Takwa Touihri",
      "Project Coordinator & Backend Developer",
      "https://cdn-icons-png.flaticon.com/512/2922/2922656.png"
    ),
    new TeamMember(
      "Ayoub Assila",
      "Flutter Mobile Developer",
      "https://cdn-icons-png.flaticon.com/512/2922/2922510.png"
    ),
    new TeamMember(
      "Ghalia Rahal",
      "Content & Data Manager",
      "https://cdn-icons-png.flaticon.com/512/2922/2922561.png"
    ),
  ]);

  return { sections, teamMembers };
}
