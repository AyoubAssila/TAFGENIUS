class Course {
  final String id;
  String title;
  String category;
  String description;
  String status;
  int students;
  String lastUpdated;

  Course({
    required this.id,
    required this.title,
    required this.category,
    this.description = '',
    this.status = 'draft',
    this.students = 0,
    required this.lastUpdated,
  });
}