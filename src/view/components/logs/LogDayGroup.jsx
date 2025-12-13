import React from "react";
import LogEntry from "./LogEntry.jsx";

export default function LogDayGroup({ label, entries }) {
  return (
    <div className="mb-4">
      <div className="d-flex align-items-center mb-2">
        <span className="me-2">🗓️</span>
        <h5 className="mb-0 fw-bold">{label}</h5>
      </div>
      {entries.map((e, i) => (
        <LogEntry
          key={i}
          time={e.time}
          icon={e.icon}
          title={e.message}
          subtitle={e.user}
          details={e.details}
          badge={e.badge}
        />
      ))}
    </div>
  );
}
