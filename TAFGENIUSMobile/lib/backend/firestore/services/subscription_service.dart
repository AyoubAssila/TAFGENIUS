import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/subscription_model.dart';

class SubscriptionService {
  final CollectionReference subscriptionCollection =
  FirebaseFirestore.instance.collection('subscriptions');

  Future<String> addSubscription(SubscriptionModel subscription) async {
    DocumentReference doc = await subscriptionCollection.add(subscription.toMap());
    return doc.id;
  }

  Future<void> updateSubscription(String subscriptionId, Map<String, dynamic> data) async {
    await subscriptionCollection.doc(subscriptionId).update(data);
  }

  Future<void> deleteSubscription(String subscriptionId) async {
    await subscriptionCollection.doc(subscriptionId).delete();
  }

  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    var snapshot = await subscriptionCollection.get();
    return snapshot.docs
        .map((doc) => SubscriptionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<SubscriptionModel?> getSubscriptionById(String subscriptionId) async {
    var doc = await subscriptionCollection.doc(subscriptionId).get();
    if (!doc.exists) return null;
    return SubscriptionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
