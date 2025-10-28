import React from "react";
import { Link, useLocation } from "react-router-dom";

function Sidebar({ isOpen, toggle }) {
  const location = useLocation();

  return (
    <div
      className={`bg-dark text-white position-fixed h-100 p-3 transition ${
        isOpen ? "d-block" : "d-none d-md-block"
      }`}
      style={{ width: "240px", zIndex: 1000 }}
    >
      <h4 className="mb-4">EduBlog</h4>
      <ul className="nav flex-column">
        <li className="nav-item mb-2">
          <Link
            to="/"
            className={`nav-link text-white ${
              location.pathname === "/" ? "fw-bold" : ""
            }`}
            onClick={toggle}
          >
            <i className="bi bi-journal-text me-2"></i> Blog
          </Link>
        </li>
        <li className="nav-item mb-2">
          <Link
            to="/about"
            className={`nav-link text-white ${
              location.pathname === "/about" ? "fw-bold" : ""
            }`}
            onClick={toggle}
          >
            <i className="bi bi-info-circle me-2"></i> About
          </Link>
        </li>
      </ul>
    </div>
  );
}

export default Sidebar;
