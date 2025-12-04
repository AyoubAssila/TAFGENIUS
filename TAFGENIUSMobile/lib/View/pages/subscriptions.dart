import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/subscription_model.dart';
import '../../Model/user_subscription_model.dart';
import '../../ViewModel/subscriptions_viewmodel.dart';
import '../components/info_row.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionsViewModel(),
      child: Consumer<SubscriptionsViewModel>(
        builder: (context, vm, _) {
          final formatter = DateFormat('dd/MM/yyyy');

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.indigo,
              child: const Icon(Icons.add),
              onPressed: () => _openCreate(context, vm),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "Subscriptions",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),

                ...vm.userSubscriptions.map((us) {
                  final sub = vm.getSubscription(us.subscriptionId);

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("${us.userId} — ${sub?.title ?? 'Unknown Plan'}"),
                      subtitle: Text(
                        "${formatter.format(us.startDate)} → ${formatter.format(us.endDate)}",
                      ),
                      trailing: Text(
                        "${sub?.price.toStringAsFixed(2) ?? '0'} TND",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () => _openDetail(context, us, sub),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openCreate(BuildContext context, SubscriptionsViewModel vm) {
    final userCtrl = TextEditingController();
    final subIdCtrl = TextEditingController();

    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(const Duration(days: 30)); // UI unchanged

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setDialog) => AlertDialog(
          title: const Text("New User Subscription"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: userCtrl,
                  decoration: const InputDecoration(labelText: "User ID"),
                ),
                TextField(
                  controller: subIdCtrl,
                  decoration: const InputDecoration(labelText: "Subscription ID"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(ctx),
            ),
            ElevatedButton(
              child: const Text("Create"),
              onPressed: () {
                if (userCtrl.text.isEmpty || subIdCtrl.text.isEmpty) return;

                vm.addUserSubscription(
                  UserSubscriptionModel(
                    id: "",
                    userId: userCtrl.text.trim(),
                    subscriptionId: subIdCtrl.text.trim(),
                    startDate: start,
                    endDate: end,
                    status: "active",
                  ),
                );

                Navigator.pop(ctx);
              },
            )
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, UserSubscriptionModel us, SubscriptionModel? sub) {
    final formatter = DateFormat('dd/MM/yyyy');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("${us.userId} — ${sub?.title ?? 'Unknown Plan'}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoRow(
              label: "Price",
              value: "${sub?.price.toStringAsFixed(2) ?? 0} TND",
            ),
            InfoRow(
              label: "Period",
              value: "${formatter.format(us.startDate)} → ${formatter.format(us.endDate)}",
            ),
            InfoRow(
              label: "Status",
              value: us.status,
            ),
            InfoRow(
              label: "Accessible Courses",
              value: "${sub?.accessibleCourses.length ?? 0} courses",
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
