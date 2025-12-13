// src/view/pages/Users.jsx

import React, { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import { FaCheckCircle, FaTimesCircle, FaClock, FaPlus, FaSearch, FaTrash } from "react-icons/fa";

import useUsers from "@viewModel/UserViewModel.js";
import Sidebar from "@components/sidebar.jsx";
import { FirebaseAuthService } from "@backend/auth/firebaseAuthService.js";

const Users = () => {
  const {
    search,
    setSearch,
    filteredUsers,
    deleteUser,
    getStatusStyle,
    roleFilter,
    setRoleFilter,
    fetchUsers,
  } = useUsers();

  const [showAdd, setShowAdd] = useState(false);
  const [name, setName] = useState("");
  const [emailInput, setEmailInput] = useState("");
  const [passwordInput, setPasswordInput] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const openAdd = () => {
    setShowAdd(true);
    setError("");
    setName("");
    setEmailInput("");
    setPasswordInput("");
  };

  const closeAdd = () => {
    setShowAdd(false);
  };

  const submitAdd = async () => {
    setError("");
    setLoading(true);
    try {
      await FirebaseAuthService.signup({
        email: emailInput.trim(),
        password: passwordInput,
        fullName: name.trim(),
        role: "content_webmaster",
      });
      await fetchUsers();
      closeAdd();
    } catch (e) {
      setError(e.message || "Failed to add user");
    } finally {
      setLoading(false);
    }
  };

  const renderStatus = (status) => {
    const { color, icon } = getStatusStyle(status);

    const icons = {
      check: <FaCheckCircle className="me-2" />,
      times: <FaTimesCircle className="me-2" />,
      clock: <FaClock className="me-2" />,
    };

    return (
      <span className={`d-flex align-items-center`} style={{ color }}>
        {icons[icon]} {status}
      </span>
    );
  };

  const getRoleLabel = (role) => {
    const r = (role || "").toLowerCase();
    if (r === "student") return "Student";
    if (r === "content_webmaster") return "Content Webmaster";
    if (r === "technical_webmaster") return "Technical Webmaster";
    if (r === "commercial") return "Commercial";
    return role || "";
  };

  return (
    <div className="d-flex min-vh-100">
      <Sidebar />
      <div
        className="p-4"
        style={{ backgroundColor: "#f8f9fa", flex: 1, height: "100vh", overflowY: "auto", overflowX: "hidden" }}
      >
      {/* Header */}
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h2 className="fw-bold mb-0">User Management</h2>
        <button className="btn btn-primary d-flex align-items-center" onClick={openAdd}>
          <FaPlus className="me-2" /> Add User
        </button>
      </div>

      {/* Filters */}
      <div className="d-flex flex-wrap gap-3 mb-4">
        <div className="position-relative" style={{ maxWidth: "400px" }}>
          <FaSearch
            style={{ position: "absolute", left: "12px", top: "10px", color: "#999" }}
          />
          <input
            type="text"
            placeholder="Search..."
            className="form-control ps-5"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>
        <div style={{ minWidth: "220px" }}>
          <select
            className="form-select"
            value={roleFilter}
            onChange={(e) => setRoleFilter(e.target.value)}
          >
            <option value="all">All roles</option>
            <option value="student">Student</option>
            <option value="content_webmaster">Content Webmaster</option>
            <option value="technical_webmaster">Technical Webmaster</option>
            <option value="commercial">Commercial</option>
          </select>
        </div>
      </div>

      {/* Table */}
      <div className="table-responsive bg-white rounded shadow-sm p-3">
        <table className="table align-middle">
          <thead>
            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Role</th>
              <th>Status</th>
              <th>.</th>
            </tr>
          </thead>
          <tbody>
            {filteredUsers.map((user) => (
              <tr key={user.id}>
                <td>{user.name}</td>
                <td>{user.email}</td>
                <td>{getRoleLabel(user.role)}</td>
                <td>{renderStatus(user.status)}</td>

                <td>
                  <button
                    className="btn btn-sm btn-danger d-flex align-items-center"
                    onClick={() => deleteUser(user.id)}
                  >
                    <FaTrash className="me-2" /> Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* Pagination */}
        <div className="d-flex justify-content-between align-items-center px-2">
          <div>
            <button className="btn btn-link p-0 me-2">Previous</button>
            <span className="fw-bold text-primary">1</span> 2 3 ...
          </div>
          <span className="text-muted">Showing 1–10 of 1,250 users</span>
        </div>
      </div>

      {showAdd && (
        <div
          className="position-fixed top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center"
          style={{ backgroundColor: "rgba(0,0,0,0.35)", zIndex: 1050 }}
        >
          <div className="card shadow-lg" style={{ width: "380px", borderRadius: "16px" }}>
            <div className="card-body">
              <h4 className="mb-3">Add User</h4>
              {error && <div className="alert alert-danger">{error}</div>}
              <div className="mb-3">
                <label className="form-label">Name</label>
                <input
                  type="text"
                  className="form-control"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Full name"
                />
              </div>
              <div className="mb-3">
                <label className="form-label">Email</label>
                <input
                  type="email"
                  className="form-control"
                  value={emailInput}
                  onChange={(e) => setEmailInput(e.target.value)}
                  placeholder="email@example.com"
                />
              </div>
              <div className="mb-3">
                <label className="form-label">Password</label>
                <input
                  type="password"
                  className="form-control"
                  value={passwordInput}
                  onChange={(e) => setPasswordInput(e.target.value)}
                  placeholder="Choose a password"
                />
              </div>
              <div className="mb-3">
                <label className="form-label">Role</label>
                <select className="form-select" value="content_webmaster" disabled>
                  <option value="content_webmaster">Webmaster contenu</option>
                </select>
              </div>
              <div className="d-flex justify-content-end gap-2">
                <button className="btn btn-outline-secondary" onClick={closeAdd} disabled={loading}>
                  Cancel
                </button>
                <button className="btn btn-primary" onClick={submitAdd} disabled={loading}>
                  {loading ? "Adding..." : "Add"}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
      </div>
    </div>
  );
};

export default Users;
