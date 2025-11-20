import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/subscription.dart';
import '../viewmodels/subscriptions_viewmodel.dart';
import '../widgets/info_row.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SubscriptionsViewModel>(context);
    final formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
        onPressed: () => _openCreate(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Subscriptions",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          ...vm.subs.map((s) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text("${s.userName} — ${s.planName}"),
                subtitle: Text(
                  "${formatter.format(s.startDate)} → ${formatter.format(s.endDate)}",
                ),
                trailing: Text(
                  "${s.price.toStringAsFixed(2)} TND",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => _openDetail(context, s),
              ),
            );
          })
        ],
      ),
    );
  }

  void _openCreate(BuildContext context) {
    final vm = Provider.of<SubscriptionsViewModel>(context, listen: false);
    final userCtrl = TextEditingController();
    final planCtrl = TextEditingController();
    final priceCtrl = TextEditingController(text: "100");

    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(const Duration(days: 30));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setDialog) => AlertDialog(
          title: const Text("New Subscription"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: userCtrl,
                  decoration: const InputDecoration(labelText: "User"),
                ),
                TextField(
                  controller: planCtrl,
                  decoration: const InputDecoration(labelText: "Plan Name"),
                ),
                TextField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
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
                if (userCtrl.text.isEmpty || planCtrl.text.isEmpty) return;

                vm.addSub(
                  SubscriptionModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    userName: userCtrl.text,
                    planName: planCtrl.text,
                    price: double.tryParse(priceCtrl.text) ?? 100,
                    startDate: start,
                    endDate: end,
                    coursesRemaining: 10,
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

  void _openDetail(BuildContext context, SubscriptionModel s) {
    final formatter = DateFormat('dd/MM/yyyy');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("${s.userName} — ${s.planName}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoRow(
              label: "Price",
              value: "${s.price.toStringAsFixed(2)} TND",
            ),
            InfoRow(
              label: "Period",
              value:
              "${formatter.format(s.startDate)} → ${formatter.format(s.endDate)}",
            ),
            InfoRow(
              label: "Remaining",
              value: "${s.coursesRemaining} courses",
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
