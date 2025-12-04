// src/Model/payment_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final double amount;
  final DateTime date;
  final String method;
  final String status;

  PaymentModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.method,
    required this.status,
  });

  // Création depuis Firestore
  factory PaymentModel.fromMap(Map<String, dynamic> map, String id) {
    return PaymentModel(
      id: id,
      amount: (map['amount'] ?? 0).toDouble(),
      date: map['date'] is Timestamp
          ? (map['date'] as Timestamp).toDate()
          : DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      method: map['method'] ?? 'Unknown',
      status: map['status'] ?? 'paid',
    );
  }

  // Conversion pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date,
      'method': method,
      'status': status,
    };
  }
}
