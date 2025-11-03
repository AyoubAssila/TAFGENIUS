// main.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(BlogApp());
}

/// ----------------- Models -----------------
enum AttachmentType { image, file, link, video }
enum PostCategory { Opinions, Experiences, Articles }

class Attachment {
  final String id;
  final AttachmentType type;
  final String name;
  final Uint8List? bytes; // image/file preview bytes
  final String? url; // path or link

  Attachment({
    required this.id,
    required this.type,
    required this.name,
    this.bytes,
    this.url,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.toString(),
    'name': name,
    'bytes': bytes != null ? base64Encode(bytes!) : null,
    'url': url,
  };

  static Attachment fromJson(Map<String, dynamic> j) {
    final t = j['type'] as String;
    AttachmentType type = AttachmentType.image;
    if (t.contains('file')) type = AttachmentType.file;
    if (t.contains('link')) type = AttachmentType.link;
    if (t.contains('video')) type = AttachmentType.video;

    return Attachment(
      id: j['id'],
      type: type,
      name: j['name'],
      bytes: j['bytes'] != null ? base64Decode(j['bytes']) : null,
      url: j['url'],
    );
  }
}

class CommentModel {
  final String id;
  final String authorName;
  final String authorRole;
  String content;
  final DateTime createdAt;
  final String? parentId;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.content,
    required this.createdAt,
    this.parentId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'authorName': authorName,
    'authorRole': authorRole,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'parentId': parentId,
  };

  static CommentModel fromJson(Map<String, dynamic> j) {
    return CommentModel(
      id: j['id'],
      authorName: j['authorName'],
      authorRole: j['authorRole'],
      content: j['content'],
      createdAt: DateTime.parse(j['createdAt']),
      parentId: j['parentId'],
    );
  }
}

class PostModel {
  final String id;
  final String authorName;
  final String authorRole;
  final DateTime createdAt;
  String text;
  List<Attachment> attachments;
  List<CommentModel> comments;
  PostCategory category;
  int likes;

  PostModel({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.createdAt,
    required this.text,
    List<Attachment>? attachments,
    List<CommentModel>? comments,
    this.category = PostCategory.Opinions,
    this.likes = 0,
  })  : attachments = attachments ?? [],
        comments = comments ?? [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'authorName': authorName,
    'authorRole': authorRole,
    'createdAt': createdAt.toIso8601String(),
    'text': text,
    'attachments': attachments.map((a) => a.toJson()).toList(),
    'comments': comments.map((c) => c.toJson()).toList(),
    'category': category.toString(),
    'likes': likes,
  };

  static PostModel fromJson(Map<String, dynamic> j) {
    final catStr = j['category'] as String? ?? PostCategory.Opinions.toString();
    PostCategory cat = PostCategory.Opinions;
    if (catStr.contains('Experiences')) cat = PostCategory.Experiences;
    if (catStr.contains('Articles')) cat = PostCategory.Articles;

    return PostModel(
      id: j['id'],
      authorName: j['authorName'],
      authorRole: j['authorRole'],
      createdAt: DateTime.parse(j['createdAt']),
      text: j['text'] ?? '',
      attachments: (j['attachments'] as List<dynamic>?)
          ?.map((x) => Attachment.fromJson(Map<String, dynamic>.from(x)))
          .toList() ??
          [],
      comments: (j['comments'] as List<dynamic>?)
          ?.map((x) => CommentModel.fromJson(Map<String, dynamic>.from(x)))
          .toList() ??
          [],
      category: cat,
      likes: j['likes'] ?? 0,
    );
  }
}

/// ----------------- App -----------------
class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAFGenius',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MainScaffold(), // now a scaffold with Drawer
    );
  }
}

/// MainScaffold contains Drawer navigation
class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0; // 0: Blog, 1: About
  final GlobalKey<BlogPageState> _blogKey = GlobalKey();

  void _onSelectMenu(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
    Navigator.of(context).pop(); // close drawer
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_selectedIndex == 0) {
      body = BlogPage(key: _blogKey);
    } else {
      body = AboutPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('EduBlog'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo),
                child: Row(
                  children: [
                    CircleAvatar(radius: 32, backgroundColor: Colors.white, child: Text('E', style: TextStyle(color: Colors.indigo, fontSize: 28))),
                    SizedBox(width: 12),
                    Expanded(child: Text('EduBlog', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              ListTile(leading: Icon(Icons.forum), title: Text('Blog'), onTap: () => _onSelectMenu(0)),
              ListTile(leading: Icon(Icons.info), title: Text('About'), onTap: () => _onSelectMenu(1)),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete_forever, color: Colors.red),
                title: Text('Clear data (dev)'),
                onTap: () async {
                  // clear JSON file using blog key
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Confirmer'),
                      content: Text('Supprimer toutes les données locales ?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Annuler')),
                        ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Supprimer')),
                      ],
                    ),
                  );
                  if (ok == true) {
                    await _blogKey.currentState?.clearAllData();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Données locales supprimées')));
                  }
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Quit'),
                onTap: () => exit(0),
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}

/// ----------------- Blog Page -----------------
class BlogPage extends StatefulWidget {
  BlogPage({Key? key}) : super(key: key);

  @override
  BlogPageState createState() => BlogPageState();
}

class BlogPageState extends State<BlogPage> {
  // user test
  final TextEditingController _nameController = TextEditingController();
  String _selectedRole = 'Étudiant';

  // posts
  final List<PostModel> _posts = [];
  final Map<String, bool> _commentsOpen = {};
  final Set<String> _likedPosts = {};

  // UI
  PostCategory _visibleCategory = PostCategory.Opinions;
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  // pickers
  final ImagePicker _picker = ImagePicker();

  // file persistence
  late final Future<Directory> _appDocDirFuture = getApplicationDocumentsDirectory();

  // local file name
  static const _fileName = 'posts.json';

  @override
  void initState() {
    super.initState();
    _loadPostsFromFile();
    _seedDemoIfEmpty();
  }

  void _seedDemoIfEmpty() {
    // load happens async; add seeds only if list empty after a small delay
    Future.delayed(Duration(milliseconds: 200), () {
      if (_posts.isEmpty) {
        final now = DateTime.now();
        final demo = [
          PostModel(
              id: 'demo1',
              authorName: 'Alice',
              authorRole: 'Étudiant',
              createdAt: now.subtract(Duration(days: 2)),
              text: 'Ceci est une opinion sur la méthode d\'apprentissage.',
              category: PostCategory.Opinions,
              likes: 2),
          PostModel(
              id: 'demo2',
              authorName: 'Bob',
              authorRole: 'Webmaster de contenu',
              createdAt: now.subtract(Duration(days: 3)),
              text: 'Expérience : création de mon premier module.',
              category: PostCategory.Experiences,
              likes: 3),
          PostModel(
              id: 'demo3',
              authorName: 'Takwa',
              authorRole: 'Webmaster de contenu',
              createdAt: now.subtract(Duration(days: 1)),
              text: 'Article : structurer un cours efficacement.',
              category: PostCategory.Articles,
              likes: 8),
        ];
        setState(() {
          if (_posts.isEmpty) {
            _posts.addAll(demo);
            for (var p in demo) _commentsOpen[p.id] = false;
          }
        });
        _savePostsToFile();
      }
    });
  }

  Future<File> _localFile() async {
    final dir = await _appDocDirFuture;
    return File('${dir.path}/$_fileName');
  }

  Future<void> _savePostsToFile() async {
    try {
      final f = await _localFile();
      final jsonList = _posts.map((p) => p.toJson()).toList();
      await f.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Save error: $e');
    }
  }

  Future<void> _loadPostsFromFile() async {
    try {
      final f = await _localFile();
      if (await f.exists()) {
        final s = await f.readAsString();
        final decoded = jsonDecode(s) as List<dynamic>;
        setState(() {
          _posts.clear();
          for (var item in decoded) {
            final p = PostModel.fromJson(Map<String, dynamic>.from(item));
            _posts.add(p);
            _commentsOpen[p.id] = false;
          }
        });
      }
    } catch (e) {
      debugPrint('Load error: $e');
    }
  }

  Future<void> clearAllData() async {
    try {
      final f = await _localFile();
      if (await f.exists()) await f.delete();
      setState(() {
        _posts.clear();
        _commentsOpen.clear();
        _likedPosts.clear();
      });
    } catch (e) {
      debugPrint('Clear error: $e');
    }
  }

  String _fmt(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);

  // -------------------- Post creation --------------------
  Future<void> _openNewPostDialog() async {
    final TextEditingController textController = TextEditingController();
    PostCategory selectedCategory = _visibleCategory;
    List<Attachment> attachments = [];

    Future<void> pickImage() async {
      final XFile? f = await _picker.pickImage(source: ImageSource.gallery);
      if (f != null) {
        final bytes = await f.readAsBytes();
        attachments.add(Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            type: AttachmentType.image,
            name: f.name,
            bytes: bytes,
            url: f.path));
      }
    }

    Future<void> pickFile() async {
      final result = await FilePicker.platform.pickFiles(withData: true);
      if (result != null && result.files.isNotEmpty) {
        final f = result.files.first;
        attachments.add(Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            type: AttachmentType.file,
            name: f.name,
            bytes: f.bytes,
            url: f.path));
      }
    }

    Future<void> pickVideo() async {
      final XFile? f = await _picker.pickVideo(source: ImageSource.gallery);
      if (f != null) {
        attachments.add(Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            type: AttachmentType.video,
            name: f.name ?? 'video',
            bytes: null,
            url: f.path));
      }
    }

    Future<void> addLink() async {
      final TextEditingController linkCtrl = TextEditingController();
      await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Ajouter un lien'),
              content: TextField(controller: linkCtrl, decoration: InputDecoration(hintText: 'https://...')),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
                ElevatedButton(
                    onPressed: () {
                      final link = linkCtrl.text.trim();
                      if (link.isNotEmpty) {
                        attachments.add(Attachment(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            type: AttachmentType.link,
                            name: link,
                            bytes: null,
                            url: link));
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Ajouter'))
              ],
            );
          });
    }

    await showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (ctx, setStateDialog) {
            bool creatingArticleNotAllowed = (selectedCategory == PostCategory.Articles && _selectedRole != 'Webmaster de contenu');
            return AlertDialog(
              title: Text('Nouvelle publication'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButton<PostCategory>(
                      isExpanded: true,
                      value: selectedCategory,
                      items: PostCategory.values.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat.toString().split('.').last));
                      }).toList(),
                      onChanged: (v) => setStateDialog(() {
                        selectedCategory = v ?? PostCategory.Opinions;
                      }),
                    ),
                    SizedBox(height: 8),
                    TextField(controller: textController, maxLines: 6, decoration: InputDecoration(hintText: 'Écris ton post...')),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton.icon(onPressed: () async { await pickImage(); setStateDialog(() {}); }, icon: Icon(Icons.image), label: Text('Image')),
                        ElevatedButton.icon(onPressed: () async { await pickVideo(); setStateDialog(() {}); }, icon: Icon(Icons.videocam), label: Text('Vidéo')),
                        ElevatedButton.icon(onPressed: () async { await pickFile(); setStateDialog(() {}); }, icon: Icon(Icons.attach_file), label: Text('Fichier')),
                        ElevatedButton.icon(onPressed: () async { await addLink(); setStateDialog(() {}); }, icon: Icon(Icons.link), label: Text('Lien')),
                      ],
                    ),
                    if (attachments.isNotEmpty)
                      Column(children: attachments.map((a) {
                        final badge = a.type == AttachmentType.image ? 'Image' : a.type == AttachmentType.video ? 'Vidéo' : a.type == AttachmentType.file ? 'Fichier' : 'Lien';
                        return ListTile(
                          dense: true,
                          title: Text(a.name),
                          subtitle: Text(badge),
                          trailing: IconButton(icon: Icon(Icons.delete), onPressed: () { setStateDialog(() { attachments.removeWhere((x) => x.id == a.id); }); }),
                        );
                      }).toList()),
                    if (creatingArticleNotAllowed)
                      Padding(padding: EdgeInsets.only(top: 8), child: Text('Création d\'articles réservée aux Webmasters de contenu.', style: TextStyle(color: Colors.red)))
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
                ElevatedButton(
                    onPressed: creatingArticleNotAllowed ? null : () {
                      final text = textController.text.trim();
                      if (text.isEmpty && attachments.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Le post est vide.')));
                        return;
                      }
                      final post = PostModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        authorName: _nameController.text.trim().isEmpty ? 'Anonyme' : _nameController.text.trim(),
                        authorRole: _selectedRole,
                        createdAt: DateTime.now(),
                        text: text,
                        attachments: List.from(attachments),
                        category: selectedCategory,
                      );
                      setState(() {
                        _posts.insert(0, post);
                        _commentsOpen[post.id] = false;
                      });
                      _savePostsToFile();
                      Navigator.pop(context);
                    },
                    child: Text('Publier'))
              ],
            );
          });
        });
  }

  // -------------------- Comments & likes --------------------
  void _addComment(String postId, String content, {String? parentId}) {
    final post = _posts.firstWhere((p) => p.id == postId);
    final comment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: _nameController.text.trim().isEmpty ? 'Anonyme' : _nameController.text.trim(),
      authorRole: _selectedRole,
      content: content,
      createdAt: DateTime.now(),
      parentId: parentId,
    );
    setState(() {
      post.comments.add(comment);
    });
    _savePostsToFile();
  }

  void _editComment(String postId, String commentId, String newContent) {
    final post = _posts.firstWhere((p) => p.id == postId);
    final c = post.comments.firstWhere((c) => c.id == commentId);
    setState(() {
      c.content = newContent;
    });
    _savePostsToFile();
  }

  void _deleteComment(String postId, String commentId) {
    final post = _posts.firstWhere((p) => p.id == postId);
    setState(() {
      post.comments.removeWhere((c) => c.id == commentId);
    });
    _savePostsToFile();
  }

  bool _canEditComment(CommentModel c) {
    final cur = _nameController.text.trim();
    return cur == c.authorName;
  }

  bool _canDeleteComment(PostModel post, CommentModel c) {
    final cur = _nameController.text.trim();
    return cur == c.authorName || cur == post.authorName;
  }

  void _toggleLike(PostModel post) {
    setState(() {
      if (_likedPosts.contains(post.id)) {
        _likedPosts.remove(post.id);
        post.likes = (post.likes - 1).clamp(0, 999999);
      } else {
        _likedPosts.add(post.id);
        post.likes += 1;
      }
    });
    _savePostsToFile();
  }

  // -------------------- UI renderers --------------------
  Widget _attachmentWidget(Attachment a) {
    if (a.type == AttachmentType.image && a.bytes != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GestureDetector(
            onTap: () => showDialog(context: context, builder: (_) => Dialog(child: Image.memory(a.bytes!))),
            child: Image.memory(a.bytes!, height: 150, fit: BoxFit.cover)),
      );
    } else if (a.type == AttachmentType.video && a.url != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoPath: a.url!))),
          child: Container(height: 160, color: Colors.black12, child: Center(child: Icon(Icons.play_circle_fill, size: 64, color: Colors.indigo))),
        ),
      );
    } else if (a.type == AttachmentType.link && a.url != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () async {
            final uri = Uri.parse(a.url!);
            if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
            else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Impossible d\'ouvrir le lien')));
          },
          child: Text(a.url!, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(children: [Icon(Icons.attach_file), SizedBox(width: 6), Expanded(child: Text(a.name))]),
      );
    }
  }

  Widget _commentsSection(PostModel post) {
    final TextEditingController commentCtrl = TextEditingController();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ...post.comments.map((c) {
        final isReply = c.parentId != null;
        return Container(
          margin: EdgeInsets.only(left: isReply ? 24 : 0, top: 8),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(radius: 14, child: Text(c.authorName.isEmpty ? 'A' : c.authorName[0].toUpperCase())),
              SizedBox(width: 8),
              Expanded(child: Text('${c.authorName} • ${c.authorRole}', style: TextStyle(fontWeight: FontWeight.w600))),
              Text(_fmt(c.createdAt), style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ]),
            SizedBox(height: 6),
            Text(c.content),
            SizedBox(height: 6),
            Row(children: [
              IconButton(icon: Icon(Icons.reply), tooltip: 'Répondre', onPressed: () {
                showModalBottomSheet(context: context, isScrollControlled: true, builder: (ctx) {
                  final tc = TextEditingController();
                  return Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text('Répondre à ${c.authorName}', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextField(controller: tc, decoration: InputDecoration(hintText: 'Écris ta réponse...')),
                        SizedBox(height: 10),
                        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Annuler')),
                          ElevatedButton(onPressed: () {
                            final content = tc.text.trim();
                            if (content.isNotEmpty) {
                              _addComment(post.id, content, parentId: c.id);
                              Navigator.pop(ctx);
                            }
                          }, child: Text('Répondre'))
                        ])
                      ]),
                    ),
                  );
                });
              }),
              SizedBox(width: 8),
              if (_canEditComment(c))
                IconButton(icon: Icon(Icons.edit), tooltip: 'Modifier', onPressed: () {
                  final editCtrl = TextEditingController(text: c.content);
                  showDialog(context: context, builder: (_) {
                    return AlertDialog(
                      title: Text('Modifier le commentaire'),
                      content: TextField(controller: editCtrl, maxLines: 4),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
                        ElevatedButton(onPressed: () {
                          final newText = editCtrl.text.trim();
                          if (newText.isNotEmpty) _editComment(post.id, c.id, newText);
                          Navigator.pop(context);
                        }, child: Text('Enregistrer'))
                      ],
                    );
                  });
                }),
              if (_canDeleteComment(post, c))
                IconButton(icon: Icon(Icons.delete, color: Colors.redAccent), tooltip: 'Supprimer', onPressed: () {
                  showDialog(context: context, builder: (_) {
                    return AlertDialog(
                      title: Text('Confirmer'),
                      content: Text('Supprimer ce commentaire ?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), onPressed: () {
                          _deleteComment(post.id, c.id);
                          Navigator.pop(context);
                        }, child: Text('Supprimer'))
                      ],
                    );
                  });
                })
            ])
          ]),
        );
      }).toList(),
      SizedBox(height: 12),
      Row(children: [
        CircleAvatar(radius: 18, child: Text((_nameController.text.isEmpty ? 'A' : _nameController.text[0].toUpperCase()))),
        SizedBox(width: 8),
        Expanded(child: TextField(controller: commentCtrl, decoration: InputDecoration(hintText: 'Écris un commentaire...'))),
        SizedBox(width: 8),
        ElevatedButton(onPressed: () {
          final content = commentCtrl.text.trim();
          if (content.isNotEmpty) {
            _addComment(post.id, content);
            commentCtrl.clear();
          }
        }, child: Text('Envoyer'))
      ])
    ]);
  }

  Widget _postCard(PostModel post) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return PostDetailPage(
            post: post,
            nameController: _nameController,
            selectedRole: _selectedRole,
            onLikeToggle: () => _toggleLike(post),
            liked: _likedPosts.contains(post.id),
            addComment: (content, {parentId}) => _addComment(post.id, content, parentId: parentId),
          );
        }));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(child: Text(post.authorName.isEmpty ? 'A' : post.authorName[0].toUpperCase())),
              SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(post.authorName, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${post.authorRole} • ${_fmt(post.createdAt)}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ]),
              Spacer(),
              Text(post.category.toString().split('.').last, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
              SizedBox(width: 8),
              if (_nameController.text.trim() == post.authorName)
                IconButton(icon: Icon(Icons.delete_forever, color: Colors.redAccent), onPressed: () {
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: Text('Confirmer'),
                    content: Text('Supprimer cette publication ?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), onPressed: () {
                        setState(() {
                          _posts.removeWhere((p) => p.id == post.id);
                          _commentsOpen.remove(post.id);
                        });
                        _savePostsToFile();
                        Navigator.pop(context);
                      }, child: Text('Supprimer'))
                    ],
                  ));
                })
            ]),
            SizedBox(height: 10),
            if (post.text.isNotEmpty) Text(post.text),
            ...post.attachments.map((a) => _attachmentWidget(a)).toList(),
            SizedBox(height: 8),
            Row(children: [
              IconButton(icon: Icon(_likedPosts.contains(post.id) ? Icons.favorite : Icons.favorite_border, color: _likedPosts.contains(post.id) ? Colors.red : null), onPressed: () => _toggleLike(post)),
              Text('${post.likes}'),
              SizedBox(width: 12),
              IconButton(icon: Icon(Icons.comment), onPressed: () { setState(() { _commentsOpen[post.id] = !(_commentsOpen[post.id] ?? false); }); }),
              Spacer(),
              Text('${post.comments.length} commentaires', style: TextStyle(color: Colors.grey[700]))
            ]),
            if (_commentsOpen[post.id] ?? false) _commentsSection(post)
          ]),
        ),
      ),
    );
  }

  List<PostModel> _filteredPosts() {
    final term = _searchTerm.trim().toLowerCase();
    return _posts.where((p) {
      if (p.category != _visibleCategory) return false;
      if (term.isEmpty) return true;
      final matchesAuthor = p.authorName.toLowerCase().contains(term);
      final matchesText = p.text.toLowerCase().contains(term);
      return matchesAuthor || matchesText;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final posts = _filteredPosts();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Row(children: [
                  Expanded(child: TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Ton nom (pour test)', border: InputBorder.none))),
                  SizedBox(width: 12),
                  DropdownButton<String>(value: _selectedRole, items: ['Étudiant', 'Webmaster de contenu'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(), onChanged: (v) => setState(() => _selectedRole = v ?? 'Étudiant'))
                ]),
              ),
            ),
            SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: ToggleButtons(
                  constraints: BoxConstraints(minHeight: 36, minWidth: 90),
                  isSelected: PostCategory.values.map((c) => c == _visibleCategory).toList(),
                  onPressed: (index) => setState(() => _visibleCategory = PostCategory.values[index]),
                  children: PostCategory.values.map((c) => Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text(c.toString().split('.').last))).toList(),
                ),
              ),
              SizedBox(width: 8),
              Container(width: 40, height: 36, child: IconButton(icon: Icon(Icons.search), onPressed: () {}))
            ]),
            SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Rechercher par auteur ou mot-clé...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12)),
              onChanged: (v) => setState(() => _searchTerm = v),
            ),
            SizedBox(height: 8),
            Expanded(
              child: posts.isEmpty ? Center(child: Text('Aucune publication pour cette catégorie / recherche.')) : ListView.builder(itemCount: posts.length, itemBuilder: (ctx, i) => _postCard(posts[i])),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _openNewPostDialog, child: Icon(Icons.post_add), tooltip: 'Nouvelle publication'),
    );
  }
}

/// ----------------- Post Detail -----------------
class PostDetailPage extends StatelessWidget {
  final PostModel post;
  final TextEditingController nameController;
  final String selectedRole;
  final VoidCallback onLikeToggle;
  final bool liked;
  final void Function(String content, {String? parentId}) addComment;

  const PostDetailPage({
    Key? key,
    required this.post,
    required this.nameController,
    required this.selectedRole,
    required this.onLikeToggle,
    required this.liked,
    required this.addComment,
  }) : super(key: key);

  String fmt(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Publication')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(child: Text(post.authorName.isEmpty ? 'A' : post.authorName[0].toUpperCase())),
            SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(post.authorName, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${post.authorRole} • ${fmt(post.createdAt)}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ]),
            Spacer(),
            Text(post.category.toString().split('.').last, style: TextStyle(color: Colors.grey[700]))
          ]),
          SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (post.text.isNotEmpty) Text(post.text),
                ...post.attachments.map((a) {
                  if (a.type == AttachmentType.image && a.bytes != null) {
                    return Padding(padding: EdgeInsets.only(top: 8), child: Image.memory(a.bytes!, height: 200, fit: BoxFit.cover));
                  } else if (a.type == AttachmentType.video && a.url != null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: GestureDetector(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoPath: a.url!))), child: Container(height: 180, color: Colors.black12, child: Center(child: Icon(Icons.play_circle_fill, size: 64, color: Colors.indigo)))),
                    );
                  } else if (a.type == AttachmentType.link && a.url != null) {
                    return Padding(padding: EdgeInsets.only(top: 8), child: InkWell(onTap: () async { final uri = Uri.parse(a.url!); if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication); }, child: Text(a.url!, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))));
                  } else {
                    return Padding(padding: EdgeInsets.only(top: 8), child: Row(children: [Icon(Icons.attach_file), SizedBox(width: 8), Expanded(child: Text(a.name))]));
                  }
                }).toList(),
                SizedBox(height: 12),
                Row(children: [
                  IconButton(icon: Icon(liked ? Icons.favorite : Icons.favorite_border, color: liked ? Colors.red : null), onPressed: onLikeToggle),
                  Text('${post.likes}'),
                  SizedBox(width: 12),
                  Icon(Icons.comment),
                  SizedBox(width: 6),
                  Text('${post.comments.length}')
                ]),
                SizedBox(height: 16),
                ...post.comments.map((c) {
                  final isReply = c.parentId != null;
                  return Container(
                    margin: EdgeInsets.only(left: isReply ? 24 : 0, top: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[50]),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [CircleAvatar(radius: 14, child: Text(c.authorName.isEmpty ? 'A' : c.authorName[0].toUpperCase())), SizedBox(width: 8), Expanded(child: Text('${c.authorName} • ${c.authorRole}', style: TextStyle(fontWeight: FontWeight.w600))), Text(fmt(c.createdAt), style: TextStyle(fontSize: 11, color: Colors.grey[600]))]),
                      SizedBox(height: 6),
                      Text(c.content),
                      SizedBox(height: 6),
                      Row(children: [
                        IconButton(icon: Icon(Icons.reply), onPressed: () {
                          showModalBottomSheet(context: context, isScrollControlled: true, builder: (ctx) {
                            final tc = TextEditingController();
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  Text('Répondre à ${c.authorName}', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  TextField(controller: tc, decoration: InputDecoration(hintText: 'Écris ta réponse...')),
                                  SizedBox(height: 10),
                                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                    TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Annuler')),
                                    ElevatedButton(onPressed: () {
                                      final content = tc.text.trim();
                                      if (content.isNotEmpty) {
                                        addComment(content, parentId: c.id);
                                        Navigator.pop(ctx);
                                      }
                                    }, child: Text('Répondre'))
                                  ])
                                ]),
                              ),
                            );
                          });
                        })
                      ])
                    ]),
                  );
                }).toList(),
                SizedBox(height: 16),
                Row(children: [CircleAvatar(child: Text(nameController.text.isEmpty ? 'A' : nameController.text[0].toUpperCase())), SizedBox(width: 8), Expanded(child: TextField(controller: commentCtrl, decoration: InputDecoration(hintText: 'Écris un commentaire...'))), SizedBox(width: 8), ElevatedButton(onPressed: () {
                  final c = commentCtrl.text.trim();
                  if (c.isNotEmpty) {
                    addComment(c);
                    commentCtrl.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Commentaire ajouté')));
                  }
                }, child: Text('Envoyer'))]),
                SizedBox(height: 36)
              ]),
            ),
          )
        ]),
      ),
    );
  }
}

/// ----------------- Video Player -----------------
class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  const VideoPlayerScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  Future<void>? _initFuture;

  @override
  void initState() {
    super.initState();
    try {
      _controller = VideoPlayerController.file(File(widget.videoPath));
      _initFuture = _controller!.initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
    } catch (e) {
      _controller = null;
      _initFuture = Future.value();
    }
  }

  @override
  void dispose() {
    _controller?.pause();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Scaffold(appBar: AppBar(title: Text('Vidéo')), body: Center(child: Text('Lecture vidéo non supportée sur cette plateforme')));
    }
    return Scaffold(
      appBar: AppBar(title: Text('Vidéo')),
      body: FutureBuilder(
        future: _initFuture,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) return Center(child: CircularProgressIndicator());
          return Center(child: AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!)));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          setState(() {
            if (_controller!.value.isPlaying) _controller!.pause();
            else _controller!.play();
          });
        },
      ),
    );
  }
}

/// ----------------- About Page -----------------
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Who we are
            Text('Who We Are', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'We are a passionate team of computer science students driven by innovation and learning. '
                      'Our project focuses on building a modern educational platform that offers accessible, '
                      'high-quality learning experiences to students and the general public. '
                      'We believe that technology can make education easier, faster, and more effective.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Mission
            Text('Our Mission', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Our mission is to create a secure and user-friendly educational platform where learners can access professional courses '
                      'and resources anytime, anywhere. We aim to support education through digital transformation by integrating local payment '
                      'solutions like Paymee Sandbox in Tunisia.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Team
            Text('Our Team', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),

            // Member 1
            _buildTeamMember(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
              name: 'Feriel Khalfaoui',
              role: 'Frontend Developer & UX Designer',
            ),
            SizedBox(height: 12),

            // Member 2
            _buildTeamMember(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922656.png',
              name: 'Takwa Touihri',
              role: 'Project Coordinator & Backend Developer',
            ),
            SizedBox(height: 12),

            // Member 3
            _buildTeamMember(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922510.png',
              name: 'Ayoub Assila',
              role: 'Flutter Mobile Developer',
            ),
            SizedBox(height: 12),

            // Member 4
            _buildTeamMember(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
              name: 'Ghalia Rahal',
              role: 'Content & Data Manager',
            ),

            SizedBox(height: 20),

            // History
            Text('Our History', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'This project began as a university initiative to develop a complete web and mobile application using modern technologies. '
                      'Our goal was to create an educational solution that allows users to learn, pay securely, and track their progress easily. '
                      'Throughout our journey, we’ve learned how to work as a team, solve real-world problems, and design a platform that combines '
                      'technology, accessibility, and education.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Vision
            Text('Our Vision', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'We aspire to expand our platform beyond its initial prototype, turning it into a real tool that empowers learners '
                      'and educators in Tunisia and beyond. Our long-term vision is to make education more digital, inclusive, and innovative.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),

            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
                label: Text('Back'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for reusable team member card
  Widget _buildTeamMember({required String imageUrl, required String name, required String role}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 6),
                  Text(role, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


