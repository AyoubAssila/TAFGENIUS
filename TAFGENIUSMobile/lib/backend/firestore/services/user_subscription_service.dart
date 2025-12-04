import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/user_subscription_model.dart';

class UserSubscriptionService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('userSubscriptions');

  Future<String> addUserSubscription(UserSubscriptionModel sub) async {
    DocumentReference doc = await collection.add(sub.toMap());
    return doc.id;
  }

  Future<void> updateUserSubscription(String id, Map<String, dynamic> data) async {
    await collection.doc(id).update(data);
  }

  Future<void> deleteUserSubscription(String id) async {
    await collection.doc(id).delete();
  }

  Future<List<UserSubscriptionModel>> getAllUserSubscriptions() async {
    var snapshot = await collection.get();
    return snapshot.docs
        .map((doc) => UserSubscriptionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<UserSubscriptionModel?> getUserSubscriptionById(String id) async {
    var doc = await collection.doc(id).get();
    if (!doc.exists) return null;
    return UserSubscriptionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
