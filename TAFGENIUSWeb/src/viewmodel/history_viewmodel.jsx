// src/ViewModel/history_viewmodel.jsx
import { useState } from "react";
import { CoursesData } from "../model/course_model";
import { QuizzesData } from "../model/quizz_model";
import { CertificatesData } from "../model/certificate_model";
import { PaymentsData } from "../model/payment_model";
import { useLocation } from "react-router-dom";

export default function useHistoryViewModel() {
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const tabParam = params.get("tab")?.toLowerCase() || "quizzes";

  const [tab, setTab] = useState(() => {
    switch (tabParam) {
      case "courses":
        return "Courses";
      case "quizzes":
        return "Quizzes";
      case "certificates":
        return "Certificates";
      case "payments":
        return "Payments";
      default:
        return "Quizzes";
    }
  });

  const getTabData = () => {
    switch (tab) {
      case "Courses":
        return CoursesData;
      case "Quizzes":
        return QuizzesData;
      case "Certificates":
        return CertificatesData;
      case "Payments":
        return PaymentsData;
      default:
        return [];
    }
  };

  return { tab, setTab, getTabData };
}
