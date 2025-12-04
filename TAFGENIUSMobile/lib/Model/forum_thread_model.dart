import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  final String id;
  final String author;
  final String content;
  final DateTime timestamp;
  int likes;

  Reply({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
    this.likes = 0,
  });

  factory Reply.fromMap(Map<String, dynamic> map, String id) {
    return Reply(
      id: id,
      author: map['author'] ?? '',
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      likes: map['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
      'timestamp': timestamp,
      'likes': likes,
    };
  }
}

class ForumThread {
  final String id;
  String title;
  String author;
  DateTime date;
  String preview;
  List<Reply> replies;
  int views;
  int likes;
  int repliesCount;

  ForumThread({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.preview,
    required this.replies,
    this.views = 0,
    this.likes = 0,
  }) : repliesCount = replies.length;

  factory ForumThread.fromMap(Map<String, dynamic> map, String id) {
    return ForumThread(
      id: id,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      preview: map['preview'] ?? '',
      replies: map['replies'] != null
          ? List<Reply>.from((map['replies'] as List)
          .map((r) => Reply.fromMap(r as Map<String, dynamic>, r['id'])))
          : [],
      views: map['views'] ?? 0,
      likes: map['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'date': date,
      'preview': preview,
      'replies': replies.map((r) => r.toMap()).toList(),
      'views': views,
      'likes': likes,
    };
  }
}
