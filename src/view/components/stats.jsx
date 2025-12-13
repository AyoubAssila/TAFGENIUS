import React from 'react';
import Card from "react-bootstrap/Card";

export default function Stats({ title, value, icon }) {
  return (
    <Card className="text-center shadow-sm m-2" style={{ borderLeft:"5px solid #007bff" }}>
      <Card.Body>
        <div className="d-flex align-items-center justify-content-center">
          <div className="me-3">{icon}</div>
          <div>
            <h6 className="text-muted">{title}</h6>
            <h4>{value}</h4>
          </div>
        </div>
      </Card.Body>
    </Card>
  );
}
