class ForumThread {
  final String id;
  final String title;
  final String author;
  final String date;
  final String preview;
  final List<Reply> replies;
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
}

class Reply {
  final String id;
  final String author;
  final String content;
  final String timestamp;
  int likes;

  Reply({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
    this.likes = 0,
  });
}