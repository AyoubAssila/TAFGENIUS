import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/payment.dart';

class PaymentsViewModel extends ChangeNotifier {
  List<Payment> _payments = [];

  List<Payment> get payments => _payments;

  PaymentsViewModel() {
    _loadDemoPayments();
  }

  void _loadDemoPayments() {
    _payments = [
      Payment(
        id: 'T1001',
        user: 'Ali Ben',
        amount: 59.9,
        course: 'Advanced Flutter',
        date: DateTime.parse('2025-10-12T10:20:00'),
        method: 'Credit Card',
        reference: 'PAY-1001',
        notes: 'Single payment',
      ),
      Payment(
        id: 'T1002',
        user: 'Sara O.',
        amount: 79.9,
        course: 'Laravel Expert',
        date: DateTime.parse('2025-10-12T08:05:00'),
        method: 'PayPal',
        reference: 'PAY-1002',
        notes: 'Discount applied',
      ),
      Payment(
        id: 'T1003',
        user: 'Yassine K',
        amount: 39.9,
        course: 'AI Basics',
        date: DateTime.parse('2025-10-11T16:00:00'),
        method: 'Credit Card',
        reference: 'PAY-1003',
        notes: '',
      ),
      Payment(
        id: 'T1004',
        user: 'Nora',
        amount: 120.0,
        course: 'Fullstack Bootcamp',
        date: DateTime.parse('2025-09-30T14:12:00'),
        method: 'Bank Transfer',
        reference: 'PAY-1004',
        notes: 'Invoice #455',
      ),
    ];
  }

  /// Groups payments by date
  Map<String, List<Payment>> get groupedPayments {
    _payments.sort((a, b) => b.date.compareTo(a.date));
    final Map<String, List<Payment>> map = {};

    for (final p in _payments) {
      map.putIfAbsent(p.dateKey, () => []).add(p);
    }
    return map;
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }
}
