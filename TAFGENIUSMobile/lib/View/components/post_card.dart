import 'package:flutter/material.dart';
import '../../Model/post_model.dart';
import '../../Model/attachment_model.dart';
import '../../Model/comment_model.dart';
import 'comment_section.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final void Function(String)? onDelete;
  final void Function(BuildContext, String)? onLike;
  final void Function(BuildContext, String, String)? onComment;
  final bool isVisitor;

  const PostCard({
    super.key,
    required this.post,
    this.onDelete,
    this.onLike,
    this.onComment,
    this.isVisitor = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(post.text),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: widget.onLike != null
                      ? () => widget.onLike!(context, post.id)
                      : null,
                ),
                Text('${post.likes} Likes'),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {
                    setState(() => showComments = !showComments);
                  },
                ),
                Text('Comment (${post.comments.length})'),
                const Spacer(),
                if (widget.onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => widget.onDelete!(post.id),
                  ),
              ],
            ),
            if (showComments && widget.onComment != null)
              CommentSection(
                comments: post.comments,
                onAdd: (text) => widget.onComment?.call(context, post.id, text),
              ),
          ],
        ),
      ),
    );
  }
}
