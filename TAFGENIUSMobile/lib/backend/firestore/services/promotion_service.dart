import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/promotion_model.dart';

class PromotionService {
  final CollectionReference promotionCollection =
  FirebaseFirestore.instance.collection('promotions');

  Future<void> addPromotion(PromotionModel promo) async {
    await promotionCollection.add(promo.toMap());
  }

  Future<List<PromotionModel>> getAllPromotions() async {
    var snapshot = await promotionCollection.get();
    return snapshot.docs
        .map((doc) => PromotionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updatePromotion(String promoId, Map<String, dynamic> data) async {
    await promotionCollection.doc(promoId).update(data);
  }

  Future<void> deletePromotion(String promoId) async {
    await promotionCollection.doc(promoId).delete();
  }
}
