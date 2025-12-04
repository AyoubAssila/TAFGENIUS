import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String password;
  String role;
  DateTime createdAt;
  DateTime? updatedAt;

  // Progrès global
  double globalProgress;

  // Progrès par cours
  Map<String, Progress> progress;

  // Champs étudiants
  String? gender;
  int? age;
  List<String> subscriptions;
  List<String> purchasedCourses;
  Map<String, AccessRight> accessRights;

  UserModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.role = 'etudiant',
    DateTime? createdAt,
    this.updatedAt,
    this.globalProgress = 0,
    Map<String, Progress>? progress,
    this.gender,
    this.age,
    List<String>? subscriptions,
    List<String>? purchasedCourses,
    Map<String, AccessRight>? accessRights,
  })  : createdAt = createdAt ?? DateTime.now(),
        progress = progress ?? {},
        subscriptions = subscriptions ?? [],
        purchasedCourses = purchasedCourses ?? [],
        accessRights = accessRights ?? {};

  // ---------------- Firestore mapping ----------------
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      if (password.isNotEmpty) "password": password,
      "role": role,
      "createdAt": Timestamp.fromDate(createdAt),
      if (updatedAt != null) "updatedAt": Timestamp.fromDate(updatedAt!),
      "globalProgress": globalProgress,
      "progress": progress.map((key, value) => MapEntry(key, value.toMap())),
      if (gender != null) "gender": gender,
      if (age != null) "age": age,
      "subscriptions": subscriptions,
      "purchasedCourses": purchasedCourses,
      "accessRights": accessRights.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? 'etudiant',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
      globalProgress: (map['globalProgress'] ?? 0).toDouble(),
      progress: (map['progress'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, Progress.fromMap(value))) ??
          {},
      gender: map['gender'],
      age: map['age'],
      subscriptions: List<String>.from(map['subscriptions'] ?? []),
      purchasedCourses: List<String>.from(map['purchasedCourses'] ?? []),
      accessRights: (map['accessRights'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, AccessRight.fromMap(value))) ??
          {},
    );
  }

  // Méthodes utilitaires
  bool get isStudent => role == 'etudiant';
  bool get isContentWebmaster => role == 'webmaster_contenu';
  bool get isTechnicalWebmaster => role == 'webmaster_technique';
  bool get isCommercial => role == 'commercial';
  bool get isAdmin => isContentWebmaster || isTechnicalWebmaster || isCommercial;

  void markUpdated() {
    updatedAt = DateTime.now();
  }
}

class Progress {
  double percent;
  String lastLessonId;
  DateTime updatedAt;
  List<String> completedLessonIds;

  Progress({
    required this.percent,
    required this.lastLessonId,
    required this.updatedAt,
    List<String>? completedLessonIds,
  }) : completedLessonIds = completedLessonIds ?? [];

  Map<String, dynamic> toMap() {
    return {
      "percent": percent,
      "lastLessonId": lastLessonId,
      "updatedAt": Timestamp.fromDate(updatedAt),
      "completedLessonIds": completedLessonIds,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      percent: (map['percent'] ?? 0).toDouble(),
      lastLessonId: map['lastLessonId'] ?? '',
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completedLessonIds: List<String>.from(map['completedLessonIds'] ?? []),
    );
  }
}

class AccessRight {
  bool hasAccess;
  String reason;
  DateTime expiresAt;

  AccessRight({
    required this.hasAccess,
    required this.reason,
    required this.expiresAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "hasAccess": hasAccess,
      "reason": reason,
      "expiresAt": Timestamp.fromDate(expiresAt),
    };
  }

  factory AccessRight.fromMap(Map<String, dynamic> map) {
    return AccessRight(
      hasAccess: map['hasAccess'] ?? false,
      reason: map['reason'] ?? 'expired',
      expiresAt: (map['expiresAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
