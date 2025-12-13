import React from "react";
import { FaSearch } from "react-icons/fa";

export default function LogFilters({ filter, setFilter, date, setDate, type, setType, period, setPeriod }) {
  return (
    <div className="d-flex flex-wrap gap-3 mb-3">
      <div className="input-group" style={{ maxWidth: 320 }}>
        <span className="input-group-text bg-white">
          <FaSearch />
        </span>
        <input
          type="text"
          className="form-control"
          placeholder="Search"
          value={filter}
          onChange={(e) => setFilter(e.target.value)}
        />
      </div>
      <div style={{ minWidth: 200 }}>
        <select className="form-select" value={type} onChange={(e) => setType(e.target.value)}>
          <option value="all">Type: All</option>
          <option value="auth">Auth</option>
          <option value="course">Course</option>
          <option value="subscription">Subscription</option>
          <option value="system">System</option>
        </select>
      </div>
      <div style={{ minWidth: 200 }}>
        <select className="form-select" value={period} onChange={(e) => setPeriod(e.target.value)}>
          <option value="today">Period: Today</option>
          <option value="yesterday">Yesterday</option>
          <option value="week">This Week</option>
          <option value="older">Older</option>
        </select>
      </div>
      <input
        type="date"
        className="form-control"
        style={{ maxWidth: 200 }}
        value={date}
        onChange={(e) => setDate(e.target.value)}
      />
    </div>
  );
}
