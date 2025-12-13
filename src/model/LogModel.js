export default function LogModel(data) {
  const ts = data.timestamp?.toDate ? data.timestamp.toDate() : new Date();
  const time =
    data.time ||
    `${ts.toISOString().slice(0, 10)} ${ts.toISOString().slice(11, 16)}`;
  return {
    userId: data.userId || "",
    courseId: data.courseId || "",
    lessonId: data.lessonId || "",
    type: data.type || "",
    details: data.details || "",
    icon: data.icon || "•",
    message: data.message || "",
    timestamp: ts,
    time,
  };
}
