import 'dart:convert';

class PromoCode {
  String id;
  String code;
  double discount;
  DateTime startDate;
  DateTime endDate;
  int usageCount;

  PromoCode({
    required this.id,
    required this.code,
    required this.discount,
    required this.startDate,
    required this.endDate,
    this.usageCount = 0,
  });

  bool get isExpired => DateTime.now().isAfter(endDate);

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'discount': discount,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'usageCount': usageCount,
  };

  static PromoCode fromJson(Map<String, dynamic> json) => PromoCode(
    id: json['id'],
    code: json['code'],
    discount: (json['discount'] as num).toDouble(),
    startDate: DateTime.parse(json['startDate']),
    endDate: DateTime.parse(json['endDate']),
    usageCount: json['usageCount'] ?? 0,
  );
}
