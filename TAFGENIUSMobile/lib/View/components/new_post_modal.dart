import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import '../../Model/post_model.dart';
import '../../Model/attachment_model.dart';

class NewPostModal extends StatefulWidget {
  final void Function(PostModel) onSave;
  final List<PostCategory> allowedCategories;
  final String buttonText;
  final String textFieldHint;

  const NewPostModal({
    super.key,
    required this.onSave,
    this.allowedCategories = const [
      PostCategory.Experiences,
      PostCategory.Articles,
      PostCategory.Motivation,
    ],
    this.buttonText = "Post",
    this.textFieldHint = "Write something...",
  });

  @override
  State<NewPostModal> createState() => _NewPostModalState();
}

class _NewPostModalState extends State<NewPostModal> {
  final TextEditingController _textController = TextEditingController();
  late PostCategory _selectedCategory;
  List<AttachmentModel> _attachments = [];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.allowedCategories.first;
  }

  void _handleSubmit() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final post = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: "Author", // Remplacé par le ViewModel avant envoi
      authorRole: "student",
      createdAt: DateTime.now(),
      text: text,
      category: _selectedCategory,
      attachments: _attachments,
    );

    widget.onSave(post);
    _textController.clear();
    setState(() {
      _attachments.clear();
    });
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _attachments.addAll(result.files.map((f) => AttachmentModel(
          id: const Uuid().v4(),
          type: 'file',
          name: f.name,
          url: f.path ?? '',
        )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // réduit la hauteur
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bar avec flèche de retour
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                const Text(
                  "New Post",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Choix de la catégorie si plusieurs disponibles
            if (widget.allowedCategories.length > 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Post Type',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.allowedCategories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return ChoiceChip(
                        label: Text(_getCategoryName(category)),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => _selectedCategory = category);
                        },
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            // Zone de texte
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: widget.textFieldHint,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 12),

            // Bouton pour ajouter des fichiers
            ElevatedButton.icon(
              onPressed: _pickFiles,
              icon: const Icon(Icons.attach_file),
              label: const Text("Add File"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
              ),
            ),

            // Affichage des fichiers ajoutés
            if (_attachments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _attachments.map((a) => Text("• ${a.name}")).toList(),
                ),
              ),

            // Bouton de publication
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(PostCategory category) {
    switch (category) {
      case PostCategory.Experiences:
        return 'Experience';
      case PostCategory.Articles:
        return 'Article';
      case PostCategory.Motivation:
        return 'Motivation';
    }
  }
}
