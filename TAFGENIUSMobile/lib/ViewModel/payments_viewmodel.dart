import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Model/payment_model.dart';

class PaymentsViewModel extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<PaymentModel> _payments = [];
  List<PaymentModel> get payments => _payments;

  PaymentsViewModel() {
    loadPayments();
  }

  // Charger les paiements depuis Firestore
  Future<void> loadPayments() async {
    try {
      final snapshot = await _db.collection('payments').get();
      _payments = snapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading payments: $e");
    }
  }

  /// Group payments by date (yyyy-MM-dd)
  Map<String, List<PaymentModel>> get groupedPayments {
    _payments.sort((a, b) => b.date.compareTo(a.date));
    final Map<String, List<PaymentModel>> map = {};
    for (final p in _payments) {
      final key = p.date.toIso8601String().split('T')[0]; // juste la date
      map.putIfAbsent(key, () => []).add(p);
    }
    return map;
  }

  Future<void> refresh() async {
    await loadPayments();
  }
}
