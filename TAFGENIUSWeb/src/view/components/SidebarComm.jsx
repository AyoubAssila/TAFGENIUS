import React from "react";

export default function Sidebar({ collapsed=false, onToggle, current, onNavigate }) {
  const items = [
    { key:"payments", label:"Payments", icon:"bi-receipt" },
    { key:"promocodes", label:"Promo Codes", icon:"bi-ticket-perforated" },
    { key:"promotions", label:"Promotions", icon:"bi-tag" },
    { key:"subscriptions", label:"Subscriptions", icon:"bi-journal-check" },
    { key:"stats", label:"Statistics", icon:"bi-bar-chart" },
  ];

  return (
    <div className="sidebar d-flex flex-column">
      <div className="brand d-flex align-items-center">
        <div style={{width:collapsed?40:48, height:collapsed?40:48, borderRadius:8, background:"#3f51b5", display:"flex", alignItems:"center", justifyContent:"center"}}><i className="bi bi-layers-fill" style={{color:"#fff", fontSize:18}}></i></div>
        {!collapsed && <div style={{marginLeft:12}}><div style={{fontWeight:700}}>Commercial Space</div><div style={{fontSize:12, color:"#cfd8ff"}}>In-memory admin</div></div>}
      </div>

      <div className="mt-3 flex-grow-1">
        {items.map(it => (
          <div key={it.key} className={`nav-item ${current===it.key ? "active" : ""}`} onClick={()=>onNavigate(it.key)} title={it.label}>
            <div className="icon"><i className={`bi ${it.icon}`}></i></div>
            {!collapsed && <div className="label">{it.label}</div>}
          </div>
        ))}
      </div>

      <div style={{padding:12}}>
        <div className="nav-item" onClick={onToggle}><div className="icon"><i className={`bi ${collapsed ? "bi-arrow-right-square":"bi-arrow-left-square"}`}></i></div>{!collapsed && <div>Toggle</div>}</div>
        <div style={{height:8}} />
        <div className="text-muted" style={{fontSize:12, paddingLeft:collapsed?0:4}}>{!collapsed && "Built with React + MVVM"}</div>
      </div>
    </div>
  );
}