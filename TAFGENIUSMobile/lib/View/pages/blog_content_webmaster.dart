import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/new_post_modal.dart';
import '../components/post_card.dart';
import '../../../viewmodel/blog_content_webmaster_viewmodel.dart';
import '../../../Model/post_model.dart';

class BlogContentWebmasterPage extends StatelessWidget {
  const BlogContentWebmasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogContentWebmasterViewModel()..initialize(),
      child: Consumer<BlogContentWebmasterViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) return const Center(child: CircularProgressIndicator());

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Blog - Webmaster'),
                bottom: TabBar(
                  onTap: (index) {
                    final tabs = ['experiences', 'articles', 'motivation'];
                    vm.changeTab(tabs[index]);
                  },
                  tabs: const [
                    Tab(icon: Icon(Icons.school), text: 'Expériences'),
                    Tab(icon: Icon(Icons.article), text: 'Articles'),
                    Tab(icon: Icon(Icons.emoji_events), text: 'Motivation'),
                  ],
                ),
              ),
              floatingActionButton: vm.selectedTab != 'experiences'
                  ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => NewPostModal(
                      allowedCategories: vm.selectedTab == 'articles'
                          ? [PostCategory.Articles]
                          : [PostCategory.Motivation],
                      onSave: (post) {
                        // Appeler addPost avec context
                        vm.addPost(
                          context,
                          text: post.text,
                          category: post.category,
                          attachments: post.attachments,
                        );
                      },
                    ),
                  );
                },
                child: const Icon(Icons.add),
              )
                  : null,
              body: TabBarView(
                children: [
                  // Experiences tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: vm.experiences
                        .map(
                          (post) => PostCard(
                        post: post,
                        onDelete: null,
                        onLike: null,
                        onComment: null,
                      ),
                    )
                        .toList(),
                  ),
                  // Articles tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: vm.articles
                        .map(
                          (post) => PostCard(
                        post: post,
                        onDelete: (postId) => vm.deletePost(context, postId),
                        onLike: null,
                        onComment: null,
                      ),
                    )
                        .toList(),
                  ),
                  // Motivation tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: vm.motivations
                        .map(
                          (post) => PostCard(
                        post: post,
                        onDelete: (postId) => vm.deletePost(context, postId),
                        onLike: null,
                        onComment: null,
                      ),
                    )
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
