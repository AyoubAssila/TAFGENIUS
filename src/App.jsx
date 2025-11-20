import React, { useState } from "react";
import Sidebar from "./components/Sidebar";
import TopbarPlaceholder from "./components/TopbarPlaceholder";
import PaymentsView from "./views/PaymentsView";
import PromoCodesView from "./views/PromoCodesView";
import PromotionsView from "./views/PromotionsView";
import SubscriptionsView from "./views/SubscriptionsView";
import StatsView from "./views/StatsView";
import { Container } from "react-bootstrap";

export default function App() {
  const [page, setPage] = useState("payments");
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);

  const renderView = () => {
    switch (page) {
      case "payments": return <PaymentsView />;
      case "promocodes": return <PromoCodesView />;
      case "promotions": return <PromotionsView />;
      case "subscriptions": return <SubscriptionsView />;
      case "stats": return <StatsView />;
      default: return <PaymentsView />;
    }
  };

  return (
    <div className={`app-root d-flex ${sidebarCollapsed ? "sidebar-collapsed" : ""}`}>
      <Sidebar
        collapsed={sidebarCollapsed}
        onToggle={() => setSidebarCollapsed(c => !c)}
        current={page}
        onNavigate={(p) => setPage(p)}
      />
      <div className="main-content flex-grow-1">
        <TopbarPlaceholder />
        <Container className="py-4">
          {renderView()}
        </Container>
      </div>
    </div>
  );
}
