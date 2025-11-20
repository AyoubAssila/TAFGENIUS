import 'package:flutter/material.dart';
import '../models/subscription.dart';

class SubscriptionsViewModel extends ChangeNotifier {
  List<SubscriptionModel> _subs = [];

  List<SubscriptionModel> get subs => _subs;

  SubscriptionsViewModel() {
    loadDemo();
  }

  void loadDemo() {
    _subs = [
      SubscriptionModel(
        id: 'S1',
        userName: 'Ali',
        planName: 'Monthly Pro',
        price: 19.99,
        startDate: DateTime(2025, 9, 1),
        endDate: DateTime(2025, 10, 1),
        coursesRemaining: 5,
      ),
      SubscriptionModel(
        id: 'S2',
        userName: 'Sara',
        planName: 'Annual',
        price: 199.99,
        startDate: DateTime(2025, 1, 15),
        endDate: DateTime(2026, 1, 15),
        coursesRemaining: 100,
      ),
    ];
  }

  void addSub(SubscriptionModel s) {
    _subs.add(s);
    notifyListeners();
  }

  void updateSub(SubscriptionModel s) {
    final i = _subs.indexWhere((x) => x.id == s.id);
    if (i >= 0) _subs[i] = s;
    notifyListeners();
  }

  void deleteSub(String id) {
    _subs.removeWhere((x) => x.id == id);
    notifyListeners();
  }
}
