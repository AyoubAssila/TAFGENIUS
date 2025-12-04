import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/blog_content_webmaster_viewmodel.dart';
import '../components/new_post_modal.dart';
import '../components/post_card.dart';
import '../../Model/post_model.dart';

class BlogContentWebmasterPage extends StatefulWidget {
  const BlogContentWebmasterPage({super.key});

  @override
  State<BlogContentWebmasterPage> createState() => _BlogContentWebmasterPageState();
}

class _BlogContentWebmasterPageState extends State<BlogContentWebmasterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BlogContentWebmasterViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogContentWebmasterViewModel(),
      child: Consumer<BlogContentWebmasterViewModel>(
        builder: (context, vm, _) {
          if (vm.loading && vm.experiences.isEmpty && vm.articles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Blog - Webmaster Contenu'),
                bottom: TabBar(
                  onTap: (index) {
                    final tabs = ['experiences', 'articles', 'motivation'];
                    vm.changeTab(tabs[index]);
                  },
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.school),
                      text: 'Expériences',
                    ),
                    Tab(
                      icon: Icon(Icons.article),
                      text: 'Articles',
                    ),
                    Tab(
                      icon: Icon(Icons.emoji_events),
                      text: 'Motivation',
                    ),
                  ],
                ),
              ),
              floatingActionButton: vm.selectedTab != 'experiences'
                  ? FloatingActionButton(
                onPressed: () {
                  // Créer un PostModel temporaire
                  showDialog(
                    context: context,
                    builder: (context) => NewPostModal(
                      onSave: (post) {
                        // Déterminer la catégorie basée sur l'onglet
                        final PostCategory category;
                        if (vm.selectedTab == 'articles') {
                          category = PostCategory.Articles;
                        } else {
                          category = PostCategory.Opinions; // Opinions pour motivation
                        }

                        // Appeler le ViewModel avec les bons paramètres
                        vm.addPost(
                          text: post.text,
                          category: category, // PostCategory au lieu de String
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
                  // Tab 1: Expériences étudiants
                  _buildExperiencesTab(vm),

                  // Tab 2: Articles
                  _buildArticlesTab(vm),

                  // Tab 3: Motivation
                  _buildMotivationTab(vm),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExperiencesTab(BlogContentWebmasterViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Statistiques
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard(
                    icon: Icons.school,
                    value: vm.experiences.length.toString(),
                    label: 'Expériences',
                    color: Colors.green,
                  ),
                  _buildStatCard(
                    icon: Icons.thumb_up,
                    value: vm.experiences.fold(0, (sum, post) => sum + post.likes).toString(),
                    label: 'Likes',
                    color: Colors.blue,
                  ),
                  _buildStatCard(
                    icon: Icons.comment,
                    value: vm.experiences.fold(0, (sum, post) => sum + post.comments.length).toString(),
                    label: 'Commentaires',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Liste des expériences
          if (vm.experiences.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  Icon(Icons.school, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Aucune expérience partagée',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            )
          else
            Column(
              children: vm.experiences.map((post) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(post.authorName.isNotEmpty ? post.authorName[0] : 'E'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.authorName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Étudiant • ${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Afficher la catégorie (si disponible)
                            if (post.category != null)
                              Chip(
                                label: Text(
                                  post.category.toString().split('.').last,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'approve') {
                                  vm.moderateExperience(post.id, true);
                                } else if (value == 'reject') {
                                  vm.moderateExperience(post.id, false);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'approve',
                                  child: Row(
                                    children: [
                                      Icon(Icons.check, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text('Approuver'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'reject',
                                  child: Row(
                                    children: [
                                      Icon(Icons.close, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Rejeter'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(post.text),
                        const SizedBox(height: 12),
                        // Utiliser PostCard pour l'affichage
                        PostCard(
                          post: post,
                          onDelete: null,
                          onLike: null,
                          onComment: null,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildArticlesTab(BlogContentWebmasterViewModel vm) {
    return _buildPostsList(
      vm: vm,
      posts: vm.articles,
      emptyMessage: 'Aucun article publié',
      emptyIcon: Icons.article,
      canDelete: true,
    );
  }

  Widget _buildMotivationTab(BlogContentWebmasterViewModel vm) {
    return _buildPostsList(
      vm: vm,
      posts: vm.motivations,
      emptyMessage: 'Aucun message de motivation',
      emptyIcon: Icons.emoji_events,
      canDelete: true,
    );
  }

  Widget _buildPostsList({
    required BlogContentWebmasterViewModel vm,
    required List<PostModel> posts,
    required String emptyMessage,
    required IconData emptyIcon,
    bool canDelete = false,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Liste des posts
          if (posts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                children: [
                  Icon(emptyIcon, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    emptyMessage,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cliquez sur + pour créer',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            )
          else
            Column(
              children: posts.map((post) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: PostCard(
                    post: post,
                    onDelete: canDelete ? vm.deletePost : null,
                    onLike: null,
                    onComment: null,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}