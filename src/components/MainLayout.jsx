import React, { useState } from "react";
import Sidebar from "./Sidebar";

function MainLayout({ children }) {
  const [isOpen, setIsOpen] = useState(false);
  return (
    <div className="d-flex">
      <Sidebar isOpen={isOpen} toggle={() => setIsOpen(!isOpen)} />
      <div className="flex-grow-1 bg-light min-vh-100">
        <nav className="navbar navbar-expand-lg navbar-light bg-white border-bottom">
          <div className="container-fluid">
            <button
              className="btn btn-outline-secondary me-2"
              onClick={() => setIsOpen(!isOpen)}
            >
              <i className="bi bi-list"></i>
            </button>
            <span className="navbar-brand mb-0 h1">EduBlog</span>
          </div>
        </nav>
        <div className="container py-4">{children}</div>
      </div>
    </div>
  );
}

export default MainLayout;
