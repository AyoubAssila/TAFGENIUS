// src/ViewModel/home_viewmodel.jsx
import { useState, useRef } from "react";
import { CoursesData } from "../model/course_model";

export function useHomeViewModel() {
  const [searchQuery, setSearchQuery] = useState("");
  const [filteredCourses, setFilteredCourses] = useState(CoursesData);
  const [isSearching, setIsSearching] = useState(false);
  const [showSearch, setShowSearch] = useState(false);
  const searchInputRef = useRef(null);

  // Affiche ou cache la barre de recherche
  const handleSearchToggle = () => {
    const newShowSearch = !showSearch;
    setShowSearch(newShowSearch);

    if (newShowSearch) {
      setTimeout(() => searchInputRef.current?.focus(), 100);
    } else {
      setSearchQuery("");
      setFilteredCourses(CoursesData);
      setIsSearching(false);
    }
  };

  // Met à jour la recherche et filtre les cours
  const handleSearchChange = (e) => {
    const query = e.target.value;
    setSearchQuery(query);

    if (!query) {
      setFilteredCourses(CoursesData);
      setIsSearching(false);
    } else {
      const filtered = CoursesData.filter((c) =>
        c.title.toLowerCase().includes(query.toLowerCase())
      );
      setFilteredCourses(filtered);
      setIsSearching(true);
    }
  };

  // Réinitialise la recherche
  const handleClearSearch = () => {
    setSearchQuery("");
    setFilteredCourses(CoursesData);
    setIsSearching(false);
    searchInputRef.current?.focus();
  };


  const getDisplayedCourses = () => filteredCourses;

  return {
    searchQuery,
    filteredCourses,
    isSearching,
    showSearch,
    searchInputRef,
    handleSearchToggle,
    handleSearchChange,
    handleClearSearch,
    getDisplayedCourses, // 🔹 Important
  };
}
