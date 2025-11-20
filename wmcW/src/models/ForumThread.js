export class ForumThread {
  constructor(id, title, author, date, preview, replies = [], views = 0, likes = 0) {
    this.id = id;
    this.title = title;
    this.author = author;
    this.date = date;
    this.preview = preview;
    this.replies = replies;
    this.views = views;
    this.likes = likes;
    this.repliesCount = replies.length;
  }
}