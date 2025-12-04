import 'lesson_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String id;
  String title;
  String description;
  String teacherId;
  String category;
  double price;
  String icon; // nouveau champ
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
    this.icon = '', // valeur par défaut
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
      "icon": icon, // ajout dans le map
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "modulesCount": modulesCount,
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
      icon: map['icon'] ?? '', // récupération du champ icon
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      modulesCount: map['modulesCount'] ?? 0,
    );
  }
}
