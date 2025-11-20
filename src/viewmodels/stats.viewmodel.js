// Stats view model (simulated data & simple transforms)
export function useStatsViewModel() {
  const totalUsers = 1245;
  const users80prog = 420;
  const usersWithCert = 98;
  const subscriptions = 312;

  const ageGroups = { "<18": 120, "18-24": 540, "25-34": 380, "35+": 205 };
  const topCourses = {
    "Motivation Mastery": 320, "Java Essentials": 280, "Laravel Bootcamp": 210,
    "Design Thinking": 180, "Productivity Hacks": 150, "React Complete": 130,
    "Python ML": 120, "UI/UX": 110, "Data Analysis": 95, "Entrepreneurship": 80,
  };

  return { totalUsers, users80prog, usersWithCert, subscriptions, ageGroups, topCourses };
}
