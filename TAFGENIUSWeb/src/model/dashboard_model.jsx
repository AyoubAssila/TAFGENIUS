// src/Model/dashboard_model.jsx

export const DashboardModel = {
  stats: [
    { title: "Courses", value: 12 },
    { title: "Quizzes", value: 8 },
    { title: "Certificates", value: 5 },
  ],
  chartData: {
    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
    datasets: [
      {
        label: "Number of Courses",
        data: [2, 3, 1, 4, 2, 3, 2],
        fill: true,
        backgroundColor: "rgba(25, 118, 210, 0.1)",
        borderColor: "#1976d2",
        tension: 0.4,
        pointBackgroundColor: "#1976d2",
        pointHoverRadius: 6,
        pointRadius: 4,
      },
    ],
  },
};
