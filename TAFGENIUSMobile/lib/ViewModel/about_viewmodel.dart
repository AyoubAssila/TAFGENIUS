import 'package:flutter/material.dart';
import '../Model/about_model.dart';

class AboutViewModel extends ChangeNotifier {
  // Sections
  final List<AboutSection> sections = [
    AboutSection(
      title: 'Who We Are',
      content: 'We are a passionate team of computer science students driven by innovation and learning. '
          'Our project focuses on building a modern educational platform that offers accessible, '
          'high-quality learning experiences to students and the general public. '
          'We believe that technology can make education easier, faster, and more effective.',
    ),
    AboutSection(
      title: 'Our Mission',
      content: 'Our mission is to create a secure and user-friendly educational platform where learners can access professional courses '
          'and resources anytime, anywhere. We aim to support education through digital transformation by integrating local payment '
          'solutions like Paymee Sandbox in Tunisia.',
    ),
    AboutSection(
      title: 'Our History',
      content: 'This project began as a university initiative to develop a complete web and mobile application using modern technologies. '
          'Our goal was to create an educational solution that allows users to learn, pay securely, and track their progress easily. '
          'Throughout our journey, we\'ve learned how to work as a team, solve real-world problems, and design a platform that combines '
          'technology, accessibility, and education.',
    ),
    AboutSection(
      title: 'Our Vision',
      content: 'We aspire to expand our platform beyond its initial prototype, turning it into a real tool that empowers learners '
          'and educators in Tunisia and beyond. Our long-term vision is to make education more digital, inclusive, and innovative.',
    ),
  ];

  // Team Members
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Feriel Khalfaoui',
      role: 'Frontend Developer & UX Designer',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
    ),
    TeamMember(
      name: 'Takwa Touihri',
      role: 'Project Coordinator & Backend Developer',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922656.png',
    ),
    TeamMember(
      name: 'Ayoub Assila',
      role: 'Flutter Mobile Developer',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922510.png',
    ),
    TeamMember(
      name: 'Ghalia Rahal',
      role: 'Content & Data Manager',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
    ),
  ];
}
