import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/blog_viewmodel.dart';
import '../components/post_card.dart';

class BlogPublicPage extends StatelessWidget {
  const BlogPublicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogViewModel(),
      child: Consumer<BlogViewModel>(
        builder: (context, vm, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: vm.posts.isEmpty
                  ? const [
                SizedBox(height: 50),
                Text("No posts available.",
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ]
                  : vm.posts
                  .map(
                    (p) => PostCard(
                  post: p,
                  onLike: vm.likePost,
                ),
              )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
