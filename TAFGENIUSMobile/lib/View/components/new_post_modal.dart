import 'package:flutter/material.dart';
import '../../Model/post_model.dart';

class NewPostModal extends StatefulWidget {
  final void Function(PostModel) onSave;
  final List<PostCategory> allowedCategories;

  const NewPostModal({
    super.key,
    required this.onSave,
    this.allowedCategories = const [
      PostCategory.Opinions,
      PostCategory.Experiences,
      PostCategory.Articles,
    ],
  });

  @override
  State<NewPostModal> createState() => _NewPostModalState();
}

class _NewPostModalState extends State<NewPostModal> {
  final TextEditingController _textController = TextEditingController();
  PostCategory _selectedCategory = PostCategory.Opinions;

  @override
  void initState() {
    super.initState();
    if (widget.allowedCategories.isNotEmpty) {
      _selectedCategory = widget.allowedCategories.first;
    }
  }

  void _handleSubmit() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final post = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: "Auteur", // Sera remplacé par le vrai nom dans le ViewModel
      authorRole: "Rôle", // Sera remplacé dans le ViewModel
      createdAt: DateTime.now(),
      text: text,
      category: _selectedCategory,
    );

    widget.onSave(post);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Sélection de catégorie (si plusieurs disponibles)
            if (widget.allowedCategories.length > 1)
              Column(
                children: [
                  const Text(
                    'Type de publication',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.allowedCategories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return ChoiceChip(
                        label: Text(_getCategoryName(category)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
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
                hintText: _getHintText(_selectedCategory),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 12),

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
                  'Publier ${_getCategoryName(_selectedCategory).toLowerCase()}',
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
      case PostCategory.Opinions:
        return 'Opinion';
      case PostCategory.Experiences:
        return 'Expérience';
      case PostCategory.Articles:
        return 'Article';
    }
  }

  String _getHintText(PostCategory category) {
    switch (category) {
      case PostCategory.Opinions:
        return 'Partagez votre opinion...';
      case PostCategory.Experiences:
        return 'Racontez votre expérience...';
      case PostCategory.Articles:
        return 'Écrivez votre article...';
    }
  }
}