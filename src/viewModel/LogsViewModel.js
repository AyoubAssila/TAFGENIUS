// src/viewmodels/LogsViewModel.js
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { firestore } from "@src/firebaseConfig.js";
import { collection, getDocs, query, orderBy, limit, startAfter } from "firebase/firestore";
import LogModel from "@model/LogModel.js";

const PAGE_SIZE = 50;

export default function useLogsViewModel() {
  const [filter, setFilter] = useState("");
  const [date, setDate] = useState("");
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const lastDocRef = useRef(null);

  const activityCol = collection(firestore, "activity");

  const fetchLogs = useCallback(async () => {
    if (loading) return;
    setLoading(true);
    try {
      const q = query(activityCol, orderBy("timestamp", "desc"), limit(PAGE_SIZE));
      const snapshot = await getDocs(q);
      const batch = snapshot.docs.map((d) => {
        const data = d.data() || {};
        const model = LogModel({
          userId: data.userId,
          courseId: data.courseId,
          lessonId: data.lessonId,
          type: data.type,
          details: data.details,
          timestamp: data.timestamp,
          icon: data.icon,
          message: data.message || data.details || "",
          time: data.time,
        });
        model.id = d.id;
        model.user = data.user || data.email || "";
        model.badge = data.badge || "";
        return model;
      });
      setLogs(batch);
      lastDocRef.current = snapshot.docs.length ? snapshot.docs[snapshot.docs.length - 1] : null;
      setHasMore(snapshot.docs.length === PAGE_SIZE);
    } finally {
      setLoading(false);
    }
  }, [activityCol, loading]);

  useEffect(() => {
    fetchLogs();
  }, [fetchLogs]);

  const loadMore = useCallback(async () => {
    if (!hasMore || loading) return;
    if (!lastDocRef.current) return;
    setLoading(true);
    try {
      const q = query(
        activityCol,
        orderBy("timestamp", "desc"),
        startAfter(lastDocRef.current),
        limit(PAGE_SIZE)
      );
      const snapshot = await getDocs(q);
      const batch = snapshot.docs.map((d) => {
        const data = d.data() || {};
        const model = LogModel({
          userId: data.userId,
          courseId: data.courseId,
          lessonId: data.lessonId,
          type: data.type,
          details: data.details,
          timestamp: data.timestamp,
          icon: data.icon,
          message: data.message || data.details || "",
          time: data.time,
        });
        model.id = d.id;
        model.user = data.user || data.email || "";
        model.badge = data.badge || "";
        return model;
      });
      setLogs((prev) => [...prev, ...batch]);
      lastDocRef.current = snapshot.docs.length ? snapshot.docs[snapshot.docs.length - 1] : lastDocRef.current;
      setHasMore(snapshot.docs.length === PAGE_SIZE);
    } finally {
      setLoading(false);
    }
  }, [activityCol, hasMore, loading]);

  const loadAll = useCallback(async () => {
    if (loading) return;
    setLoading(true);
    try {
      let cursor = lastDocRef.current;
      let more = true;
      while (more) {
        const q = cursor
          ? query(activityCol, orderBy("timestamp", "desc"), startAfter(cursor), limit(PAGE_SIZE))
          : query(activityCol, orderBy("timestamp", "desc"), limit(PAGE_SIZE));
        const snapshot = await getDocs(q);
        if (!snapshot.docs.length) break;
        const batch = snapshot.docs.map((d) => {
          const data = d.data() || {};
          const model = LogModel({
            userId: data.userId,
            courseId: data.courseId,
            lessonId: data.lessonId,
            type: data.type,
            details: data.details,
            timestamp: data.timestamp,
            icon: data.icon,
            message: data.message || data.details || "",
            time: data.time,
          });
          model.id = d.id;
          model.user = data.user || data.email || "";
          model.badge = data.badge || "";
          return model;
        });
        setLogs((prev) => [...prev, ...batch]);
        cursor = snapshot.docs[snapshot.docs.length - 1];
        more = snapshot.docs.length === PAGE_SIZE;
      }
      lastDocRef.current = cursor;
      setHasMore(false);
    } finally {
      setLoading(false);
    }
  }, [activityCol, loading]);

  const filteredLogs = useMemo(() => {
    const q = filter.toLowerCase().trim();
    return logs.filter((log) => {
      const text = (log.message || "").toLowerCase();
      const matchText =
        !q ||
        text.includes(q) ||
        (log.details || "").toLowerCase().includes(q) ||
        (log.type || "").toLowerCase().includes(q) ||
        (log.userId || "").toLowerCase().includes(q);
      const matchDate = date ? (log.time || "").startsWith(date) : true;
      return matchText && matchDate;
    });
  }, [logs, filter, date]);

  const exportLogs = () => {
    const csv =
      "data:text/csv;charset=utf-8," +
      filteredLogs.map((l) => `${l.time},${l.icon} ${l.message}`).join("\n");
    const encoded = encodeURI(csv);
    const link = document.createElement("a");
    link.setAttribute("href", encoded);
    link.setAttribute("download", "logs.csv");
    document.body.appendChild(link);
    link.click();
  };

  return {
    filter,
    setFilter,
    date,
    setDate,
    logs,
    filteredLogs,
    loading,
    hasMore,
    exportLogs,
    loadMore,
    loadAll,
  };
}
