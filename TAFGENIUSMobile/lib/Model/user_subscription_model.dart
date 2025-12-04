import 'package:cloud_firestore/cloud_firestore.dart';

class UserSubscriptionModel {
  String id;
  String userId;
  String subscriptionId;
  DateTime startDate;
  DateTime endDate;
  String status; // "active" | "expired" | "canceled"

  UserSubscriptionModel({
    this.id = '',
    required this.userId,
    required this.subscriptionId,
    required this.startDate,
    required this.endDate,
    this.status = 'active',
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'subscriptionId': subscriptionId,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  factory UserSubscriptionModel.fromMap(Map<String, dynamic> map, String id) {
    return UserSubscriptionModel(
      id: id,
      userId: map['userId'] ?? '',
      subscriptionId: map['subscriptionId'] ?? '',
      startDate: (map['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (map['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'active',
    );
  }
}
