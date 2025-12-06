import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/post_model.dart';
import '../components/post_card.dart';
import '../../../viewmodel/blog_viewmodel.dart';

class BlogPublicPage extends StatelessWidget {
  const BlogPublicPage({super.key});

  void _showSignupDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign up to $action"),
        content: const Text("You need to sign up or log in to perform this action."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/login');
            },
            child: const Text("Sign Up / Login"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogViewModel>(
      create: (_) => BlogViewModel()..initialize(),
      child: Consumer<BlogViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) return const Center(child: CircularProgressIndicator());

          // Utilisez vm.experiences au lieu de vm.posts
          final visiblePosts = vm.experiences; // Changer ceci

          return Scaffold(
            appBar: AppBar(
              title: const Text("Student Blog - Public"),
            ),
            body: visiblePosts.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "No posts available yet.\nBe the first to share!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            )
                : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: visiblePosts
                    .map(
                      (post) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PostCard(
                      post: post,
                      onLike: (ctx, postId) =>
                          _showSignupDialog(ctx, "like"),
                      onComment: (ctx, postId, text) =>
                          _showSignupDialog(ctx, "comment"),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}