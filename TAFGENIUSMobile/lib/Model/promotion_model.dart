import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  String id;
  String code;
  String occasion;
  String condition;
  double discountPercent;
  DateTime validFrom;
  DateTime validUntil;
  String? courseId;
  DateTime createdAt;
  int usageCount;
  int maxUsage;

  PromotionModel({
    this.id = '',
    required this.code,
    required this.occasion,
    required this.condition,
    required this.discountPercent,
    required this.validFrom,
    required this.validUntil,
    this.courseId,
    DateTime? createdAt,
    this.usageCount = 0,
    required this.maxUsage,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'occasion': occasion,
      'condition': condition,
      'discountPercent': discountPercent,
      'validFrom': validFrom,
      'validUntil': validUntil,
      'courseId': courseId,
      'createdAt': createdAt,
      'usageCount': usageCount,
      'maxUsage': maxUsage,
    };
  }

  factory PromotionModel.fromMap(Map<String, dynamic> map, String id) {
    return PromotionModel(
      id: id,
      code: map['code'] ?? '',
      occasion: map['occasion'] ?? '',
      condition: map['condition'] ?? '',
      discountPercent: (map['discountPercent'] ?? 0).toDouble(),
      validFrom: (map['validFrom'] as Timestamp?)?.toDate() ?? DateTime.now(),
      validUntil: (map['validUntil'] as Timestamp?)?.toDate() ?? DateTime.now(),
      courseId: map['courseId'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      usageCount: map['usageCount'] ?? 0,
      maxUsage: map['maxUsage'] ?? 0,
    );
  }
}
