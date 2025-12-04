import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  String id;
  String title; // ex: "Mensuel", "3 months"
  double price;
  int durationDays;
  List<String> accessibleCourses; // courseIds
  DateTime createdAt;

  SubscriptionModel({
    this.id = '',
    required this.title,
    required this.price,
    required this.durationDays,
    List<String>? accessibleCourses,
    DateTime? createdAt,
  })  : accessibleCourses = accessibleCourses ?? [],
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'durationDays': durationDays,
      'accessibleCourses': accessibleCourses,
      'createdAt': createdAt,
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map, String id) {
    return SubscriptionModel(
      id: id,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      durationDays: map['durationDays'] ?? 0,
      accessibleCourses: List<String>.from(map['accessibleCourses'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
