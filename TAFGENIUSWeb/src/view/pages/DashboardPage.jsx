import React from "react";
import { Line } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from "chart.js";
import { useDashboardViewModel } from "../../viewmodel/dashboard_viewmodel";

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

export default function DashboardPage() {
  const {
    stats,
    chartData,
    progressTooltip,
    setProgressTooltip,
    handleCardClick,
  } = useDashboardViewModel();

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: { legend: { display: false }, tooltip: { callbacks: { label: (ctx) => `${ctx.parsed.y} course(s)` } } },
    scales: { x: { ticks: { display: true }, grid: { display: false } }, y: { ticks: { display: false }, grid: { display: true } } },
  };

  return (
    <div className="container" style={{ marginLeft: "240px", paddingTop: "80px", paddingBottom: "40px", maxWidth: "900px" }}>
      <h2 className="mb-4" style={{ fontWeight: 700 }}> Dashboard</h2>

      {/* Statistiques cliquables */}
      <div className="row mb-4">
        {stats.map((s, i) => (
          <div key={i} className="col-12 col-md-4 mb-3">
            <div
              className="card shadow-sm h-100 text-center"
              style={{ cursor: "pointer", transition: "transform 0.2s, box-shadow 0.2s", border: "none" }}
              onClick={() => handleCardClick(s.title)}
              onMouseEnter={(e) => { e.currentTarget.style.transform = "scale(1.05)"; e.currentTarget.style.boxShadow = "0 6px 18px rgba(0,0,0,0.15)"; }}
              onMouseLeave={(e) => { e.currentTarget.style.transform = "scale(1)"; e.currentTarget.style.boxShadow = "0 4px 10px rgba(0,0,0,0.08)"; }}
            >
              <div className="card-body">
                <h3 className="text-primary" style={{ fontWeight: 700 }}>{s.value}</h3>
                <p className="mb-0" style={{ color: "#555" }}>{s.title}</p>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Total Progress */}
      <div
        className="card mb-4 shadow-sm"
        style={{ position: "relative", cursor: "pointer", transition: "transform 0.2s", border: "none" }}
        onMouseEnter={() => setProgressTooltip(true)}
        onMouseLeave={() => setProgressTooltip(false)}
      >
        <div className="card-body">
          <h5 className="card-title" style={{ fontWeight: 600 }}>Total Progress</h5>
          <div className="progress" style={{ height: "25px" }}>
            <div className="progress-bar bg-success" role="progressbar" style={{ width: "65%" }} aria-valuenow={65} aria-valuemin={0} aria-valuemax={100}></div>
          </div>
          {progressTooltip && <div style={{ position: "absolute", top: "5px", right: "15px", background: "#000", color: "#fff", padding: "2px 6px", borderRadius: "4px", fontSize: "12px" }}>65%</div>}
        </div>
      </div>

      {/* Graphique activité quotidienne */}
      <div className="card shadow-sm mb-4" style={{ height: "250px", border: "none" }}>
        <div className="card-body">
          <Line data={chartData} options={chartOptions} />
        </div>
      </div>
    </div>
  );
}
