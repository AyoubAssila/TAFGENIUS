import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/blog_etudiant_viewmodel.dart';
import '../components/new_post_modal.dart';
import '../components/post_card.dart';

class BlogEtudiantPage extends StatefulWidget {
  const BlogEtudiantPage({super.key});

  @override
  State<BlogEtudiantPage> createState() => _BlogEtudiantPageState();
}

class _BlogEtudiantPageState extends State<BlogEtudiantPage> {
  late BlogEtudiantViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = BlogEtudiantViewModel();
    vm.initialize(); // Initialisation unique
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogEtudiantViewModel>.value(
      value: vm,
      child: Consumer<BlogEtudiantViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- Header ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Blog Étudiant',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: const Color(0xFF06112A),
                                    fontWeight: FontWeight.bold)),
                            Text('Partagez vos opinions et expériences',
                                style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                        Chip(
                          label: Text('${vm.posts.length} posts',
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: const Color(0xFF06112A),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --- Nouveau post ---
                    NewPostModal(
                      onSave: (post) {
                        vm.addPost(
                          text: post.text,
                          attachments: post.attachments,
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // --- Message d'erreur ---
                    if (vm.errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(child: Text(vm.errorMessage!)),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: vm.clearError,
                            ),
                          ],
                        ),
                      ),

                    // --- Filtres (optionnel) ---
                    const Text(
                      'Catégories:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF06112A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(label: const Text('Tout'), selected: true, onSelected: (_) {}),
                        FilterChip(label: const Text('Opinions'), selected: false, onSelected: (_) {}),
                        FilterChip(label: const Text('Expériences'), selected: false, onSelected: (_) {}),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- Liste des posts ---
                    vm.posts.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Column(
                        children: [
                          Icon(Icons.forum, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text("Aucun post pour le moment",
                              style: TextStyle(color: Colors.grey, fontSize: 16)),
                          SizedBox(height: 8),
                          Text("Soyez le premier à partager !",
                              style: TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    )
                        : Column(
                      children: vm.posts.map((post) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: PostCard(
                            post: post,
                            onDelete: vm.deletePost,
                            onLike: vm.likePost,
                            onComment: vm.addComment,
                          ),
                        );
                      }).toList(),
                    ),

                    // --- Statistiques ---
                    const SizedBox(height: 32),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.thumb_up, color: const Color(0xFF06112A)),
                                const SizedBox(height: 4),
                                Text(
                                  '${vm.posts.fold(0, (sum, post) => sum + post.likes)}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Text('Likes totaux',
                                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.comment, color: Colors.green),
                                const SizedBox(height: 4),
                                Text(
                                  '${vm.posts.fold(0, (sum, post) => sum + post.comments.length)}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Text('Commentaires',
                                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.person, color: Colors.orange),
                                const SizedBox(height: 4),
                                Text(
                                  '${vm.posts.map((p) => p.authorName).toSet().length}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Text('Auteurs',
                                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
