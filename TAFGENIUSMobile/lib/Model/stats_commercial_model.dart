class StatsData {
  final int totalUsers;
  final Map<String, int> ageGroups;
  final int users80Progress;
  final int usersWithCertificates;
  final Map<String, int> topCourses;

  StatsData({
    required this.totalUsers,
    required this.ageGroups,
    required this.users80Progress,
    required this.usersWithCertificates,
    required this.topCourses,
  });
}