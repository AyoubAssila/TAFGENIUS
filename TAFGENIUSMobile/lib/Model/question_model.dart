class QuestionOption {
  String id;
  String text;
  bool isCorrect;

  QuestionOption({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
    };
  }

  factory QuestionOption.fromMap(Map<String, dynamic> map) {
    return QuestionOption(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      isCorrect: map['isCorrect'] ?? false,
    );
  }
}

class QuestionModel {
  String id;
  String type; // mcq | true or false
  List<QuestionOption> options;

  QuestionModel({
    this.id = '',
    required this.type,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'options': options.map((o) => o.toMap()).toList(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map, String id) {
    return QuestionModel(
      id: id,
      type: map['type'] ?? 'mcq',
      options: (map['options'] as List<dynamic>?)
          ?.map((o) => QuestionOption.fromMap(o))
          .toList() ??
          [],
    );
  }
}
