import 'package:cloud_firestore/cloud_firestore.dart';
import 'attachment_model.dart';
import 'comment_model.dart';

enum PostCategory { Experiences, Articles, Motivation }

class PostModel {
  final String id;
  final String authorName;
  final String authorRole; // student | content_webmaster | visitor
  final DateTime createdAt;
  String text;
  List<AttachmentModel> attachments;
  PostCategory category;
  int likes;
  List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.createdAt,
    required this.text,
    List<AttachmentModel>? attachments,
    List<CommentModel>? comments,
    required this.category,
    this.likes = 0,
  })  : attachments = attachments ?? [],
        comments = comments ?? [];

  Map<String, dynamic> toMap() {
    return {
      'authorName': authorName,
      'authorRole': authorRole,
      'createdAt': createdAt,
      'text': text,
      'category': category.name,
      'likes': likes,
      'attachments': attachments.map((a) => a.toMap()).toList(),
      'comments': comments.map((c) => c.toMap()).toList(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map, String id) {
    return PostModel(
      id: id,
      authorName: map['authorName'] ?? '',
      authorRole: map['authorRole'] ?? 'visitor',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      text: map['text'] ?? '',
      attachments: (map['attachments'] as List<dynamic>?)
          ?.map((a) => AttachmentModel.fromMap(a))
          .toList() ??
          [],
      comments: (map['comments'] as List<dynamic>?)
          ?.map((c) => CommentModel.fromMap(c, c['id'] ?? ''))
          .toList() ??
          [],
      category: PostCategory.values.firstWhere(
              (e) => e.name == (map['category'] ?? 'Experiences'),
          orElse: () => PostCategory.Experiences),
      likes: map['likes'] ?? 0,
    );
  }
}
