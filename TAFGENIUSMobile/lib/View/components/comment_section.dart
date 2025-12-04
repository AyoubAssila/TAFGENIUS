import 'package:flutter/material.dart';
import '../../Model/comment_model.dart';

class CommentSection extends StatefulWidget {
  final List<CommentModel> comments;
  final void Function(String) onAdd;

  const CommentSection({super.key, required this.comments, required this.onAdd});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController controller = TextEditingController();

  void handleAdd() {
    if (controller.text.trim().isEmpty) return;
    widget.onAdd(controller.text.trim());
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.comments.map((c) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${c.authorName} - ${c.createdAt.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(c.content),
              const Divider(),
            ],
          ),
        )),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Write a comment...",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: handleAdd,
            ),
          ],
        ),
      ],
    );
  }
}
