import 'package:flutter/material.dart';
import '../../ViewModel/dashboard_webcontenu_viewmodel.dart';
import '../../Model/forum_thread_model.dart';

class MessagingTab extends StatelessWidget {
  final DashboardViewModel viewModel;

  const MessagingTab({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final threads = viewModel.forumThreads;

    if (threads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.forum, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Forum Threads',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'No messages yet. Start a discussion!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: threads.length,
      itemBuilder: (context, index) {
        final thread = threads[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(thread.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(thread.preview),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.comment, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(thread.repliesCount.toString()),
                const SizedBox(width: 16),
                Icon(Icons.thumb_up, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(thread.likes.toString()),
              ],
            ),
            onTap: () {
              // Ouvrir modal ou page de détails pour voir et ajouter des replies
              viewModel.setShowRepliesModal(true, thread);
            },
          ),
        );
      },
    );
  }
}
