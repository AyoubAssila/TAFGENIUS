import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/new_post_modal.dart';
import '../components/post_card.dart';
import '../../../viewmodel/blog_etudiant_viewmodel.dart';
import '../../../Model/post_model.dart';

class BlogEtudiantPage extends StatefulWidget {
  const BlogEtudiantPage({super.key});

  @override
  State<BlogEtudiantPage> createState() => _BlogEtudiantPageState();
}

class _BlogEtudiantPageState extends State<BlogEtudiantPage> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogEtudiantViewModel()..initialize(),
      child: Consumer<BlogEtudiantViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) return const Center(child: CircularProgressIndicator());

          // Filtrage des posts selon la catégorie sélectionnée
          final filteredPosts = selectedCategory == 'All'
              ? vm.posts
              : vm.posts.where((post) {
            switch (selectedCategory) {
              case 'Experiences':
                return post.category == PostCategory.Experiences;
              case 'Articles':
                return post.category == PostCategory.Articles;
              case 'Motivation':
                return post.category == PostCategory.Motivation;
              default:
                return true;
            }
          }).toList();

          return Scaffold(
            appBar: AppBar(title: const Text("Blog - Étudiants")),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Modal pour ajouter un post (Motivation uniquement)
                  NewPostModal(
                    allowedCategories: [PostCategory.Motivation],
                    onSave: (post) => vm.addPost(
                      context, // passage obligatoire du context
                      text: post.text,
                      attachments: post.attachments,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Filtre par catégorie
                  Wrap(
                    spacing: 8,
                    children: ['All', 'Experiences', 'Articles', 'Motivation']
                        .map((cat) {
                      return FilterChip(
                        label: Text(cat),
                        selected: selectedCategory == cat,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Liste des posts
                  if (filteredPosts.isEmpty)
                    const Center(
                      child: Text(
                        "No posts available.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    Column(
                      children: filteredPosts.map((post) {
                        return PostCard(
                          post: post,
                          onLike: (context, postId) => vm.likePost(context, postId),
                          onComment: (context, postId, text) => vm.addComment(context, postId, text),
                          onDelete: (postId) => vm.deletePost(postId),
                        );

                      }).toList(),
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
