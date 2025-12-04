// src/ViewModel/dashboard_viewmodel.jsx
import { useState } from "react";
import { DashboardModel } from "../model/dashboard_model";

export function useDashboardViewModel() {
  const [progressTooltip, setProgressTooltip] = useState(false);

  // Les données statiques du dashboard
  const stats = DashboardModel.stats;
  const chartData = DashboardModel.chartData;

  // Fonction pour gérer la redirection sur clic d’une carte
  const handleCardClick = (type) => {
    window.location.href = `/history?tab=${type.toLowerCase()}`;
  };

  return {
    stats,
    chartData,
    progressTooltip,
    setProgressTooltip,
    handleCardClick,
  };
}
