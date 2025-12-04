import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  String id;
  String userId;
  String category; // experience | article | motivation
  String content;
  String type; // image | video | pdf
  String contentUrl;
  DateTime createdAt;
  DateTime updatedAt;
  String status; // published | pending | rejected

  BlogModel({
    this.id = '',
    required this.userId,
    required this.category,
    required this.content,
    required this.type,
    required this.contentUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.status = 'pending',
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'category': category,
      'content': content,
      'type': type,
      'contentUrl': contentUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map, String id) {
    return BlogModel(
      id: id,
      userId: map['userId'] ?? '',
      category: map['category'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? 'image',
      contentUrl: map['contentUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'pending',
    );
  }
}
