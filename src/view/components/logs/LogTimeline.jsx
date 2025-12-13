import React, { useMemo, useState } from "react";
import LogDayGroup from "./LogDayGroup.jsx";
import LogFilters from "./LogFilters.jsx";

function labelForDateStr(dayStr) {
  const now = new Date();
  const todayStr = now.toISOString().slice(0, 10);
  const y = new Date(now);
  y.setDate(now.getDate() - 1);
  const yesterdayStr = y.toISOString().slice(0, 10);
  if (dayStr === todayStr) return "Today";
  if (dayStr === yesterdayStr) return "Yesterday";
  return dayStr;
}

export default function LogTimeline({ logs, filter, setFilter, date, setDate }) {
  const [type, setType] = useState("all");
  const [period, setPeriod] = useState("today");
  const filtered = useMemo(() => {
    const byText = (l) =>
      !filter ||
      (l.message || "").toLowerCase().includes(filter.toLowerCase());
    const byDate = (l) => !date || (l.time || "").startsWith(date);
    const byType = (l) => {
      if (type === "all") return true;
      const t = (l.type || "").toLowerCase();
      if (type === "auth") return t === "auth";
      if (type === "course") return t === "course";
      if (type === "subscription") return t === "subscription";
      if (type === "system") return t === "system";
      return true;
    };
    return (logs || []).filter((l) => byText(l) && byDate(l) && byType(l));
  }, [logs, filter, date, type]);

  const grouped = useMemo(() => {
    const byDay = {};
    filtered
      .slice()
      .sort((a, b) => {
        const at = a.timestamp || new Date(a.time || 0);
        const bt = b.timestamp || new Date(b.time || 0);
        return bt - at;
      })
      .forEach((l) => {
        const dayStr =
          (l.time && l.time.slice(0, 10)) ||
          (l.timestamp ? l.timestamp.toISOString().slice(0, 10) : new Date().toISOString().slice(0, 10));
        const label = labelForDateStr(dayStr);
        if (!byDay[label]) byDay[label] = [];
        byDay[label].push(l);
      });
    return byDay;
  }, [filtered]);

  const labels = Object.keys(grouped);

  return (
    <div>
      <LogFilters
        filter={filter}
        setFilter={setFilter}
        date={date}
        setDate={setDate}
        type={type}
        setType={setType}
        period={period}
        setPeriod={setPeriod}
      />
      {labels.map((label) => (
        <LogDayGroup key={label} label={label} entries={grouped[label]} />
      ))}
    </div>
  );
}
