import 'package:flutter/material.dart';
import '../../Model/post_model.dart';
import '../../Model/attachment_model.dart';
import '../../Model/comment_model.dart';
import 'comment_section.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final void Function(String)? onDelete;
  final void Function(String)? onLike;
  final void Function(String, String)? onComment;

  const PostCard({
    super.key,
    required this.post,
    this.onDelete,
    this.onLike,
    this.onComment,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showComments = false;

  Widget renderAttachment(AttachmentModel a) {
    switch (a.type) {
      case 'image':
        return a.url.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Image.network(a.url),
        )
            : const SizedBox.shrink();
      case 'video':
        return Text("Video: ${a.name}");
      case 'link':
        return Text("Link: ${a.url}", style: const TextStyle(color: Colors.blue));
      case 'file':
      default:
        return Text("File: ${a.name}");
    }
  }

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
            // Header : Auteur et date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("${post.createdAt.toLocal()}".split(' ')[0],
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),

            // Contenu texte
            Text(post.text),
            const SizedBox(height: 8),

            // Attachments
            ...post.attachments.map(renderAttachment),

            const SizedBox(height: 12),

            // Actions : like, comment, delete
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: widget.onLike != null ? () => widget.onLike!(post.id) : null,
                ),
                Text('${post.likes}'),
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () => setState(() => showComments = !showComments),
                ),
                Text('Comments (${post.comments.length})'),
                const Spacer(),
                if (widget.onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => widget.onDelete!(post.id),
                  ),
              ],
            ),

            // Section commentaires
            if (showComments && widget.onComment != null)
              CommentSection(
                comments: post.comments,
                onAdd: (text) => widget.onComment!(post.id, text),
              ),
          ],
        ),
      ),
    );
  }
}
