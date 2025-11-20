import React from "react";
import { Card, Row, Col } from "react-bootstrap";
import { Bar, Pie } from "react-chartjs-2";
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, ArcElement, Tooltip, Legend } from "chart.js";
import { useStatsViewModel } from "../viewmodels/stats.viewmodel";

ChartJS.register(CategoryScale, LinearScale, BarElement, ArcElement, Tooltip, Legend);

export default function StatsView() {
  const { totalUsers, users80prog, usersWithCert, subscriptions, ageGroups, topCourses } = useStatsViewModel();

  const pieData = { labels: Object.keys(ageGroups), datasets: [{ data: Object.values(ageGroups), backgroundColor: ["#3f51b5","#ff9800","#4caf50","#9c27b0"] }] };
  const barData = { labels: Object.keys(topCourses), datasets: [{ label: "Enrollments", data: Object.values(topCourses), backgroundColor: "#3f51b5" }] };

  return (
    <div>
      <h4 className="fw-bold mb-3">Commercial Dashboard</h4>

      <Row className="g-3">
        <Col md={3}><Card className="p-3"><div className="d-flex align-items-center"><div className="me-3 circle-icon bg-indigo"><i className="bi bi-people-fill"></i></div><div><div className="text-muted">Users</div><div className="h5 mb-0">{totalUsers}</div></div></div></Card></Col>
        <Col md={3}><Card className="p-3"><div className="d-flex align-items-center"><div className="me-3 circle-icon bg-warning"><i className="bi bi-graph-up"></i></div><div><div className="text-muted">≥80% Progress</div><div className="h5 mb-0">{users80prog}</div></div></div></Card></Col>
        <Col md={3}><Card className="p-3"><div className="d-flex align-items-center"><div className="me-3 circle-icon bg-success"><i className="bi bi-award"></i></div><div><div className="text-muted">Certificates</div><div className="h5 mb-0">{usersWithCert}</div></div></div></Card></Col>
        <Col md={3}><Card className="p-3"><div className="d-flex align-items-center"><div className="me-3 circle-icon bg-purple"><i className="bi bi-card-list"></i></div><div><div className="text-muted">Subscriptions</div><div className="h5 mb-0">{subscriptions}</div></div></div></Card></Col>
      </Row>

      <div className="row mt-4">
        <div className="col-md-6 mb-3"><Card className="p-3 h-100"><h6>Age Distribution</h6><div style={{height:300}}><Pie data={pieData} /></div></Card></div>
        <div className="col-md-6 mb-3"><Card className="p-3 h-100"><h6>Top 10 Sold Courses</h6><div style={{height:300}}><Bar data={barData} options={{ responsive:true, plugins:{ legend:{ display:false } } }} /></div></Card></div>
      </div>

      <div className="mt-3"><Card className="p-3"><h6>Other Metrics</h6><div className="d-flex flex-column gap-2"><div className="d-flex justify-content-between"><div>Conversion Rate</div><div>4.2%</div></div><div className="d-flex justify-content-between"><div>Average Course Duration</div><div>3h 20m</div></div><div className="d-flex justify-content-between"><div>Average Rating</div><div>4.5 / 5</div></div><div className="d-flex justify-content-between"><div>Monthly Growth</div><div className="text-success">+12%</div></div></div></Card></div>
    </div>
  );
}
