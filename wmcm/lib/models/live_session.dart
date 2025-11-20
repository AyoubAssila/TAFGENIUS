class LiveSession {
  final String id;
  String title;
  String schedule;
  String description;
  int participants;
  bool isActive;
  String? meetLink;

  LiveSession({
    required this.id,
    required this.title,
    required this.schedule,
    this.description = '',
    this.participants = 0,
    this.isActive = false,
    this.meetLink,
  });
}