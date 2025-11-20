class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.role = 'student',
    this.avatar = '',
  });
}