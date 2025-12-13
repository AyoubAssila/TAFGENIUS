import React from "react";
import LogIcon from "./LogIcon.jsx";

export default function LogEntry({ time, icon, title, subtitle, details, badge }) {
  return (
    <div className="card border-0 shadow-sm mb-3">
      <div className="card-body">
        <div className="d-flex align-items-start justify-content-between">
          <div className="d-flex align-items-start">
            <div className="me-3" style={{ width: 8, height: 8, borderRadius: 8, background: "#6c63ff", marginTop: 6 }} />
            <div>
              <div className="text-muted" style={{ fontSize: "0.9rem" }}>{time}</div>
              <div className="d-flex align-items-center fw-semibold" style={{ fontSize: "1.05rem" }}>
                <LogIcon icon={icon} />
                <span>{title || "No message provided"}</span>
              </div>
              {subtitle && <div className="text-muted">{subtitle}</div>}
              {details && <div className="mt-2">{details}</div>}
            </div>
          </div>
          {badge && <span className="badge rounded-pill bg-success">{badge}</span>}
        </div>
      </div>
    </div>
  );
}
