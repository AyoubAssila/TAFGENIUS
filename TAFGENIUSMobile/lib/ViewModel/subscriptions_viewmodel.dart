import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/subscription_model.dart';
import '../Model/user_subscription_model.dart';

class SubscriptionsViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<SubscriptionModel> _subscriptions = [];
  List<UserSubscriptionModel> _userSubscriptions = [];

  List<SubscriptionModel> get subs => _subscriptions;
  List<UserSubscriptionModel> get userSubscriptions => _userSubscriptions;

  SubscriptionsViewModel() {
    loadSubscriptions();
    loadUserSubscriptions();
  }

  // LOAD ALL SUBSCRIPTION PLANS
  void loadSubscriptions() {
    _db.collection("subscriptions").snapshots().listen((snapshot) {
      _subscriptions = snapshot.docs
          .map((doc) => SubscriptionModel.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    });
  }

  // LOAD ALL USER SUBSCRIPTIONS
  void loadUserSubscriptions() {
    _db.collection("user_subscriptions").snapshots().listen((snapshot) {
      _userSubscriptions = snapshot.docs
          .map((doc) => UserSubscriptionModel.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    });
  }

  // GET SUBSCRIPTION PLAN
  SubscriptionModel? getSubscription(String id) {
    try {
      return _subscriptions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  // ADD SUBSCRIPTION PLAN
  Future<void> addSubscription(SubscriptionModel s) async {
    final ref = await _db.collection("subscriptions").add(s.toMap());
    s.id = ref.id;
    notifyListeners();
  }

  // ADD USER SUBSCRIPTION
  Future<void> addUserSubscription(UserSubscriptionModel us) async {
    final ref = await _db.collection("user_subscriptions").add(us.toMap());
    us.id = ref.id;
    notifyListeners();
  }

  // UPDATE SUBSCRIPTION
  Future<void> updateSubscription(SubscriptionModel s) async {
    await _db.collection("subscriptions").doc(s.id).update(s.toMap());
    notifyListeners();
  }

  // DELETE SUBSCRIPTION
  Future<void> deleteSubscription(String id) async {
    await _db.collection("subscriptions").doc(id).delete();
  }

  // DELETE USER SUBSCRIPTION
  Future<void> deleteUserSubscription(String id) async {
    await _db.collection("user_subscriptions").doc(id).delete();
  }
}
