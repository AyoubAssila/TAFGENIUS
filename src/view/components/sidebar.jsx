import React from "react";
import { Link } from "react-router-dom";

const Sidebar = () => {
  return (
    <div
      className="d-flex flex-column p-3 text-white bg-dark"
      style={{ width: "250px", height: "100vh", flex: "0 0 250px" }}
    >
      <h4 className="text-center mb-4">TAFGENIUS</h4>

      <ul className="nav nav-pills flex-column mb-auto">
        <li>
          <Link to="/admin-technique/dashboard" className="nav-link text-white">
            📊 Dashboard
          </Link>
        </li>
        <li>
          <Link to="/admin-technique/users" className="nav-link text-white">
            👥 Users
          </Link>
        </li>
        <li>
          <Link to="/admin-technique/logs" className="nav-link text-white">
             📊 Logs
          </Link>
        </li>
      </ul>
    </div>
  );
};

export default Sidebar;
