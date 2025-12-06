import 'lesson_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String id;
  String title;
  String description;
  String teacherId;
  String category;
  double price;
  String icons;
  DateTime createdAt;
  DateTime updatedAt;
  int modulesCount;
  List<LessonModel> lessons;

  CourseModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.teacherId,
    required this.category,
    required this.price,
    this.icons = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.modulesCount = 0,
    List<LessonModel>? lessons,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        lessons = lessons ?? [];

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "teacherId": teacherId,
      "category": category,
      "price": price,
      "icons": icons,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "modulesCount": modulesCount,
      "lessons": lessons.map((l) => l.toMap()).toList(),
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map, String id) {
    return CourseModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      teacherId: map['teacherId'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      icons: map['icons'] ?? '', // correction du champ
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      modulesCount: map['modulesCount'] ?? 0,
      lessons: map['lessons'] != null
          ? (map['lessons'] as List)
          .asMap()
          .entries
          .map((e) => LessonModel.fromMap(e.value, e.key.toString()))
          .toList()
          : [],
    );
  }
}
