import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/promotion_model.dart';

class PromotionsViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<PromotionModel> _promotions = [];
  List<PromotionModel> get promotions => _promotions;

  PromotionsViewModel() {
    loadPromotions();
  }

  void loadPromotions() {
    _db.collection("promotions").snapshots().listen((snapshot) {
      _promotions = snapshot.docs
          .map((doc) => PromotionModel.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    });
  }

  Future<void> addPromotion(PromotionModel p) async {
    final ref = await _db.collection("promotions").add(p.toMap());
    p.id = ref.id;
    notifyListeners();
  }

  Future<void> updatePromotion(PromotionModel p) async {
    await _db.collection("promotions").doc(p.id).update(p.toMap());
  }

  Future<void> deletePromotion(String id) async {
    await _db.collection("promotions").doc(id).delete();
  }
}
