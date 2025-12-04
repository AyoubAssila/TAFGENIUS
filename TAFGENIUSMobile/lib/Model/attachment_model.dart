class AttachmentModel {
  final String id;
  final String type; // "image" | "file" | "link" | "video"
  final String name;
  final String url;

  AttachmentModel({
    required this.id,
    required this.type,
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'url': url,
    };
  }

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id'] ?? '',
      type: map['type'] ?? 'file',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
