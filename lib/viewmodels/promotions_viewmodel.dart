import 'package:flutter/material.dart';
import '../models/promotion.dart';

class PromotionsViewModel extends ChangeNotifier {
  List<PromotionModel> _promotions = [];

  List<PromotionModel> get promotions => _promotions;

  PromotionsViewModel() {
    loadDemo();
  }

  void loadDemo() {
    _promotions = [
      PromotionModel(
        id: 'P1',
        title: "Back to School",
        start: DateTime(2025, 9, 1),
        end: DateTime(2025, 9, 15),
        recurrence: 'yearly',
        condition: 'All users',
        percentOff: 20,
      ),
      PromotionModel(
        id: 'P2',
        title: "October Awareness",
        start: DateTime(DateTime.now().year, 10, 1),
        end: DateTime(DateTime.now().year, 10, 31),
        recurrence: 'yearly',
        condition: 'Women only',
        percentOff: 30,
      ),
    ];
  }

  void addPromotion(PromotionModel p) {
    _promotions.add(p);
    notifyListeners();
  }

  void updatePromotion(PromotionModel p) {
    final i = _promotions.indexWhere((x) => x.id == p.id);
    if (i >= 0) _promotions[i] = p;
    notifyListeners();
  }

  void deletePromotion(String id) {
    _promotions.removeWhere((x) => x.id == id);
    notifyListeners();
  }
}
