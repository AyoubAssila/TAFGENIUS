import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/promotion.dart';
import '../viewmodels/promotions_viewmodel.dart';
import '../widgets/info_row.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PromotionsViewModel>(context);
    final formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => _openCreate(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Promotions",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          ...vm.promotions.map((p) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  p.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${formatter.format(p.start)} → ${formatter.format(p.end)}",
                ),
                trailing: Text("${p.percentOff.toStringAsFixed(0)}%"),
                onTap: () => _openDetail(context, p),
                onLongPress: () => vm.deletePromotion(p.id),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _openCreate(BuildContext context) {
    final vm = Provider.of<PromotionsViewModel>(context, listen: false);
    final titleCtrl = TextEditingController();
    final percentCtrl = TextEditingController(text: "10");

    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(const Duration(days: 10));

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, setStateDialog) {
          return AlertDialog(
            title: const Text("Create Promotion"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: percentCtrl,
                    decoration: const InputDecoration(labelText: 'Percent Off'),
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(child: Text("Start: ${DateFormat('dd/MM').format(start)}")),
                      TextButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx2,
                            initialDate: start,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) setStateDialog(() => start = d);
                        },
                        child: const Text("Pick"),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(child: Text("End: ${DateFormat('dd/MM').format(end)}")),
                      TextButton(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx2,
                            initialDate: end,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) setStateDialog(() => end = d);
                        },
                        child: const Text("Pick"),
                      )
                    ],
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
                  if (titleCtrl.text.trim().isEmpty) return;

                  vm.addPromotion(
                    PromotionModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleCtrl.text.trim(),
                      start: start,
                      end: end,
                      percentOff: double.tryParse(percentCtrl.text) ?? 10,
                    ),
                  );

                  Navigator.pop(ctx);
                },
              )
            ],
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, PromotionModel p) {
    final formatter = DateFormat('dd/MM/yyyy');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(p.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoRow(
              label: "Period",
              value: "${formatter.format(p.start)} → ${formatter.format(p.end)}",
            ),
            InfoRow(
              label: "Discount",
              value: "${p.percentOff.toStringAsFixed(0)}%",
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
