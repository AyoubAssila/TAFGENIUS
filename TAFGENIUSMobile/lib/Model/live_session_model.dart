import 'package:cloud_firestore/cloud_firestore.dart';

class LiveSession {
  final String id;
  String title;
  DateTime schedule;
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

  factory LiveSession.fromMap(Map<String, dynamic> map, String id) {
    return LiveSession(
      id: id,
      title: map['title'] ?? '',
      schedule: (map['schedule'] as Timestamp).toDate(),
      description: map['description'] ?? '',
      participants: map['participants'] ?? 0,
      isActive: map['isActive'] ?? false,
      meetLink: map['meetLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'schedule': schedule,
      'description': description,
      'participants': participants,
      'isActive': isActive,
      'meetLink': meetLink,
    };
  }
}
