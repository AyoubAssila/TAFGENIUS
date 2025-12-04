class LessonModel {
  String id;
  String title;
  String type; // video | pdf
  String contentUrl;
  int duration; // en secondes
  int order;
  bool isFree;

  LessonModel({
    this.id = '',
    required this.title,
    required this.type,
    required this.contentUrl,
    required this.duration,
    required this.order,
    required this.isFree,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "type": type,
      "contentUrl": contentUrl,
      "duration": duration,
      "order": order,
      "isFree": isFree,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map, String id) {
    return LessonModel(
      id: id,
      title: map['title'] ?? '',
      type: map['type'] ?? 'video',
      contentUrl: map['contentUrl'] ?? '',
      duration: map['duration'] ?? 0,
      order: map['order'] ?? 0,
      isFree: map['isFree'] ?? false,
    );
  }
}
