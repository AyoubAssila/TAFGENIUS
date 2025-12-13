// src/views/Logs.jsx

import React from "react";
import "bootstrap/dist/css/bootstrap.min.css";

import { FaDownload, FaPlus } from "react-icons/fa";

import useLogsViewModel from "@viewModel/LogsViewModel.js";
import Sidebar from "@components/sidebar.jsx";
import LogTimeline from "@components/logs/LogTimeline.jsx";

const Logs = () => {
  const {
    filter,
    setFilter,

    date,
    setDate,

    filteredLogs,

    exportLogs,
    loadMore,
    loadAll,
  } = useLogsViewModel();

  return (
    <div className="d-flex min-vh-100">
      <Sidebar />
      <div className="container-fluid p-4" style={{ backgroundColor: "#f9fafc", flex: 1, height: "100vh", overflowY: "auto", overflowX: "hidden" }}>
      <h3 className="fw-bold text-primary mb-4">Activity logs</h3>

      <div className="card shadow-sm border-0 rounded-3">
        <div className="card-body">
          <LogTimeline logs={filteredLogs} filter={filter} setFilter={setFilter} date={date} setDate={setDate} />
          <div className="d-flex justify-content-end mt-3 gap-2">
            <button className="btn btn-outline-secondary" onClick={loadAll}>
              <FaPlus className="me-2" /> Load all
            </button>
            <button className="btn btn-outline-secondary" onClick={loadMore}>
              <FaPlus className="me-2" /> Load more
            </button>
            <button className="btn btn-primary" onClick={exportLogs}>
              <FaDownload className="me-2" /> Export logs
            </button>
          </div>
        </div>
      </div>
      </div>
    </div>
  );
};

export default Logs;
