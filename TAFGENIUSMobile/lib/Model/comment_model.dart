import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String authorName;
  final String authorRole;
  String content;
  final DateTime createdAt;
  final String? parentId;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.content,
    required this.createdAt,
    this.parentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'authorName': authorName,
      'authorRole': authorRole,
      'content': content,
      'createdAt': createdAt,
      'parentId': parentId,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map, String id) {
    return CommentModel(
      id: id,
      authorName: map['authorName'] ?? '',
      authorRole: map['authorRole'] ?? '',
      content: map['content'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      parentId: map['parentId'],
    );
  }
}
